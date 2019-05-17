function [dist, proj] = distancePointMesh(point, vertices, faces, varargin)
%DISTANCEPOINTMESH  Shortest distance between a (3D) point and a triangle mesh.
%
%   DIST = distancePointMesh(POINT, VERTICES, FACES)
%   Returns the shortest distance between the query point POINT and the
%   triangular mesh defined by the set of vertex coordinates VERTICES and
%   the set of faces FACES. VERTICES is a NV-by-3 array, and FACES is a
%   NF-by-3 array of vertex indices.
%   If FACES is NF-by-4 array, it is converted to a (NF*2)-by-3 array.
%
%   [DIST, PROJ] = distancePointMesh(...)
%   Also returns the projection of the query point on the triangular mesh.
%
%   ... = distancePointMesh(..., 'algorithm', ALGO)
%   Allows to choose the type of algorithm. Options are:
%   * sequential:   process each face sequentially, using the function
%               distancePointTriangle3d 
%   * vectorized:   vectorized algorithm, usually faster for large number
%               of faces
%   * auto:         (default) automatically choose the most appropriate
%               between sequential and vectorized.
%
%   Example
%     [V, F] = torusMesh();
%     F2 = triangulateFaces(F);
%     P = [10 20 30];
%     [D, PROJ] = distancePointMesh(P, V, F2);
%     figure; drawMesh(V, F)
%     view(3); axis equal; lighting gouraud; light;
%     drawPoint3d(P);
%     drawPoint3d(PROJ, 'm*');
%     drawEdge3d([P PROJ], 'linewidth', 2, 'color', 'b');
%
%   See also
%     distancePointTriangle3d
%
%   References
%   * "Distance Between Point and Triangle in 3D", David Eberly (1999)
%   https://www.geometrictools.com/Documentation/DistancePoint3Triangle3.pdf
%   * <a href="matlab:
%     web('https://fr.mathworks.com/matlabcentral/fileexchange/22857-distance-between-a-point-and-a-triangle-in-3d')
%   ">Distance between a point and a triangle in 3d</a>, by Gwendolyn Fischer.
%   * <a href="matlab:
%     web('https://fr.mathworks.com/matlabcentral/fileexchange/52882-point2trimesh------distance%C2%A0between-point-and-triangulated-surface')
%   ">Distance Between Point and Triangulated Surface</a>, by Daniel Frisch.
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-03-08,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.


%% Parses input arguments

% check the case of mesh given as structure
if isstruct(vertices)
    faces = vertices.faces;
    vertices = vertices.vertices;
end

% default option
algo = 'auto';

% check optional arguments
while length(varargin) > 1
    varName = varargin{1};
    if ~ischar(varName)
        error('Require options as parameter name-value pairs');
    end
    
    if strcmpi(varName, 'algorithm')
        algo = varargin{2};
    else
        error(['Unknown option name: ' varName]);
    end
    
    varargin(1:2) = [];
end

% number of faces
nFaces = size(faces, 1);

if size(faces, 2) > 3 || iscell(faces)
    faces = triangulateFaces(faces);
end

% If algorithm is chosen automatically, choose depending on face number
if strcmpi(algo, 'auto')
    if size(faces, 1) > 30
        algo = 'vectorized';
    else
        algo = 'sequential';
    end
end

% switch to vectorized algorithm if necessary
if strcmpi(algo, 'vectorized')
    if nargout > 1
        [dist, proj] = distancePointTrimesh_vectorized(point, vertices, faces);
    else
        dist = distancePointTrimesh_vectorized(point, vertices, faces);
    end
    return;
end


%% Sequential algorithm
% For each point, iterates over the triangular faces

% allocate memory for result
nPoints = size(point, 1);
dist = zeros(nPoints, 1);

if nargout > 1
    projPoints = zeros(nPoints, 3);
end

% iterate over points
for i = 1:nPoints
    % % min distance and projection for current point
    minDist = inf;
    proj = [0 0 0];
    
    % iterate over faces
    for iFace = 1:nFaces
        % create triange for current face
        face = faces(iFace, :);
        triangle = vertices(face, :);
        
        [distf, projf] = distancePointTriangle3d(point(i,:), triangle);
        
        if distf < minDist
            minDist = distf;
            proj = projf;
        end
    end
    
    dist(i) = minDist;
    if nargout > 1
        projPoints(i,:) = proj;
    end
end
end

function [dist, proj] = distancePointTrimesh_vectorized(point, vertices, faces)
%DISTANCEPOINTTRIMESH Vectorized version of the distancePointTrimesh function 
%
%   output = distancePointTrimesh_vectorized(input)
%
%   This version is  vectorized over faces: for each query point, the
%   minimum distance to each triangular face is computed in parallel.
%   Then the minimum distance over faces is kept.
%
%   Example
%   distancePointTrimesh
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-03-08,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

% Regions are not numbered as in the original paper of D. Eberly to allow
% automated computation of regions from the 3 conditions on lines.
% Region indices are computed as follow:
%   IND = b2 * 2^2 + b1 * 2 + b0
% with:
%   b0 = 1 if s < 0, 0 otherwise
%   b1 = 1 if t < 0, 0 otherwise
%   b2 = 1 if s+t > 1, 0 otherwise
% resulting ion the following region indices:
%        /\ t
%        |
%   \ R5 |
%    \   |
%     \  |
%      \ |
%       \| P3
%        *
%        |\
%        | \
%   R1   |  \   R4
%        |   \
%        | R0 \ 
%        |     \ 
%        | P1   \ P2
%  ------*-------*------> s
%        |        \   
%   R3   |   R2    \   R6 

% allocate memory for result
nPoints = size(point, 1);
dist = zeros(nPoints, 1);
proj = zeros(nPoints, 3);

% triangle origins and direction vectors
p1  = vertices(faces(:,1),:);
v12 = vertices(faces(:,2),:) - p1;
v13 = vertices(faces(:,3),:) - p1;

% identify coefficients of second order equation that do not depend on
% query point
a = dot(v12, v12, 2);
b = dot(v12, v13, 2);
c = dot(v13, v13, 2);

% iterate on query points
for i = 1:nPoints
    % coefficients of second order equation that depend on query point
    diffP = bsxfun(@minus, p1, point(i, :));
    d = dot(v12, diffP, 2);
    e = dot(v13, diffP, 2);
    
    % compute position of projected point in the plane of the triangle
    det = a .* c - b .* b;
    s   = b .* e - c .* d;
    t   = b .* d - a .* e;
    
    % compute region index (one for each face)
    regIndex = (s < 0) + 2 * (t < 0) + 4 * (s + t > det);
    
    % for each region, process all faces whose projection fall within it
    
    % region 0
    % the minimum distance occurs inside the triangle
    inds = regIndex == 0;
    s(inds) = s(inds) ./ det(inds);
    t(inds) = t(inds) ./ det(inds);
    

    % region 1 (formerly region 3)
    % The minimum distance must occur on the line s = 0
    inds = find(regIndex == 1);
    s(inds) = 0;
    t(inds(e(inds) >= 0)) = 0;
    
    inds2 = inds(e(inds) < 0);
    bool3 = c(inds2) <= -e(inds2);
    t(inds2(bool3)) = 1;
    inds3 = inds2(~bool3);
    t(inds3) = -e(inds3) ./ c(inds3);
    
    
    % region 2 (formerly region 5)
    % The minimum distance must occur on the line t = 0
    inds = find(regIndex == 2);
    t(inds) = 0;
    s(inds(d(inds) >= 0)) = 0;

    inds2 = inds(d(inds) < 0);
    bool3 = a(inds2) <= -d(inds2);
    s(inds2(bool3)) = 1;
    inds3 = inds2(~bool3);
    s(inds3) = -d(inds3) ./ a(inds3);


    % region 3 (formerly region 4)
    % The minimum distance must occur
    % * on the line t = 0
    % * on the line s = 0 with t >= 0
    % * at the intersection of the two lines
    inds = find(regIndex == 3);
    
    inds2 = inds(d(inds) < 0);
    % minimum on edge t = 0 with s > 0.
    t(inds2) = 0;
    bool3 = a(inds2) <= -d(inds2);
    s(inds2(bool3)) = 1;
    inds3 = inds2(~bool3);
    s(inds3) = -d(inds3) ./ a(inds3);
      
    inds2 = inds(d(inds) >= 0);
    % minimum on edge s = 0
    s(inds2) = 0;
    bool3 = e(inds2) >= 0;
    t(inds2(bool3)) = 0;
    bool3 = e(inds2) < 0 & c(inds2) <= e(inds2);
    t(inds2(bool3)) = 1;
    bool3 = e(inds2) < 0 & c(inds2) > e(inds2);
    inds3 = inds2(bool3);
    t(inds3) = -e(inds3) ./ c(inds3);
    

    % region 4 (formerly region 1)
    % The minimum distance must occur on the line s + t = 1
    inds = find(regIndex == 4);
    numer = (c(inds) + e(inds)) - (b(inds) + d(inds));
    s(inds(numer <= 0)) = 0;
    inds2 = inds(numer > 0);
    numer = numer(numer > 0);
    denom = a(inds2) - 2 * b(inds2) + c(inds2);
    s(inds2(numer > denom)) = 1;
    bool3 = numer <= denom;
    s(inds2(bool3)) = numer(bool3) ./ denom(bool3);
    t(inds) = 1 - s(inds);


    % Region 5 (formerly region 2)
    % The minimum distance must occur:
    % * on the line s + t = 1
    % * on the line s = 0 with t <= 1
    % * or at the intersection of the two (s=0; t=1)
    inds = find(regIndex == 5);
    tmp0 = b(inds) + d(inds);
    tmp1 = c(inds) + e(inds);
    
    % minimum on edge s+t = 1, with s > 0
    bool2 = tmp1 > tmp0;
    inds2 = inds(bool2);
    numer = tmp1(bool2) - tmp0(bool2);
    denom = a(inds2) - 2 * b(inds2) + c(inds2);
    bool3 = numer < denom;
    s(inds2(~bool3)) = 1;
    inds3 = inds2(bool3);
    s(inds3) = numer(bool3) ./ denom(bool3);
    t(inds2) = 1 - s(inds2);
    
    % minimum on edge s = 0, with t <= 1
    inds2 = inds(~bool2);
    s(inds2) = 0;
    t(inds2(tmp1(~bool2) <= 0)) = 1;
    t(inds2(tmp1(~bool2) > 0 & e(inds2) >= 0)) = 0;
    inds3 = inds2(tmp1(~bool2) > 0 & e(inds2) < 0);
    t(inds3) = -e(inds3) ./ c(inds3);

        
    % region 6 (formerly region 6)
    % The minimum distance must occur
    % * on the line s + t = 1
    % * on the line t = 0, with s <= 1
    % * at the intersection of the two lines (s=1; t=0)
    inds = find(regIndex == 6);
    tmp0 = b(inds) + e(inds);
    tmp1 = a(inds) + d(inds);
    
    % minimum on edge s+t=1, with t > 0
    bool2 = tmp1 > tmp0;
    inds2 = inds(bool2);
    numer = tmp1(bool2) - tmp0(bool2);
    denom = a(inds2) - 2 * b(inds2) + c(inds2);
    bool3 = numer <= denom;
    t(inds2(~bool3)) = 1;
    inds3 = inds2(bool3);
    t(inds3) = numer(bool3) ./ denom(bool3);
    s(inds2) = 1 - t(inds2);

    % minimum on edge t = 0 with s <= 1
    inds2 = inds(~bool2);
    t(inds2) = 0;
    s(inds2(tmp1(~bool2) <= 0)) = 1;
    s(inds2(tmp1(~bool2) > 0 & d(inds2) >= 0)) = 0;
    inds3 = inds2(tmp1(~bool2) > 0 & d(inds2) < 0);
    s(inds3) = -d(inds3) ./ a(inds3);
    

    % compute coordinates of closest point on plane
    projList = p1 + bsxfun(@times, s, v12) + bsxfun(@times, t, v13);
    
    % squared distance between point and closest point on plane
    [dist(i), ind] = min(sum((bsxfun(@minus, point(i,:), projList)).^2, 2));

    % keep the valid projection
    proj(i, :) = projList(ind,:);
end

% convert squared distance to distance
dist = sqrt(dist);

end