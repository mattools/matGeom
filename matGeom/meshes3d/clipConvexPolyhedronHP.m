function [nodes2, faces2] = clipConvexPolyhedronHP(nodes, faces, plane)
%CLIPCONVEXPOLYHEDRONHP Clip a convex polyhedron by a plane.
%
%   [NODES2, FACES2] = clipConvexPolyhedronHP(NODES, FACES, PLANE)
%
%   return the new (convex) polyhedron whose vertices are 'below' the
%   specified plane, and with faces clipped accordingly. NODES2 contains
%   clipped vertices and new created vertices, FACES2 contains references
%   to NODES2 vertices.
%
%   Example
%     [N, F] = createCube;
%     P = createPlane([.5 .5 .5], [1 1 1]);
%     [N2, F2] = clipConvexPolyhedronHP(N, F, P);
%     figure('color','w'); view(3); axis equal
%     drawPolyhedron(N2, F2);
% 
%     [v, f] = createSoccerBall;
%     p = createPlane([-.5 .5 -.5], [1 1 1]);
%     [v2, f2] = clipConvexPolyhedronHP(v, f, p);
%     figure('color','w'); view(3); axis equal
%     drawMesh(v, f, 'faceColor', 'none');
%     drawMesh(v2, f2);
%
%   See also
%     meshes3d, polyhedra, planes3d
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2007-09-14,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


%% Preprocessing

% used for identifying identical vertices
tol = 1e-10;

% if faces is a numeric array, convert it to cell array
if isnumeric(faces)
    faces2 = cell(size(faces, 1), 1);
    for f = 1:length(faces2)
        faces2{f} = faces(f,:);
    end
    faces = faces2;
end

% find vertices below the plane
b = isBelowPlane(nodes, plane);

% initialize results
Nn  = size(nodes, 1);
nodes2 = zeros(0, 3);   % list of new nodes
faces2 = faces;         % list of new faces. Start with initial list, and remove some of them


%% Main iteration on faces

% iterate on each face, and test if either:
%   - all points below plane -> keep all face
%   - all points up plane -> remove face
%   - both -> clip the polygon
keep = true(length(faces), 1);
for f = 1:length(faces)
    % current face
    face = faces{f};
    bf = b(face);

    % face totally above plane
    if sum(bf) == 0
        keep(f) = false;
        continue;
    end

    % face totally below plane
    if sum(bf == 1) == length(bf)
        continue;
    end

    % clip polygon formed by face
    poly = nodes(face, :);
    clipped = clipConvexPolygon3dHP(poly, plane);

    % identify indices of polygon vertices
    inds = zeros(1, size(clipped, 1));
    faceb = face(bf==1); % indices of vertices still in clipped face
    [minDists, I] = minDistancePoints(nodes(faceb,:), clipped); %#ok<ASGLU>
    for i = 1:length(I)
        inds(I(i)) = faceb(i);
    end

    % indices of new points in clipped polygon
    indNews = find(inds == 0);
    
    if size(nodes2, 1) < 2
        nodes2 = [nodes2; clipped(indNews, :)]; %#ok<AGROW>
        inds(indNews(1)) = Nn + 1;
        inds(indNews(2)) = Nn + 2;
        faces2{f} = inds;
        continue;
    end
     
    % distances from new vertices to already added vertices
    [minDists, I] = minDistancePoints(clipped(indNews, :), nodes2);
    
    % compute index of first vertex
    if minDists(1) < tol
        inds(indNews(1)) = Nn + I(1);
    else
        nodes2 = [nodes2; clipped(indNews(1), :)]; %#ok<AGROW>
        inds(indNews(1)) = Nn + size(nodes2, 1);
    end
    
    % compute index of second vertex
    if minDists(2) < tol
        inds(indNews(2)) = Nn + I(2);
    else
        nodes2 = [nodes2; clipped(indNews(2), :)]; %#ok<AGROW>
        inds(indNews(2)) = Nn + size(nodes2, 1);
    end
    
    % stores the modified face
    faces2{f} = inds;
end


%% Postprocessing

% creates a new face formed by the added nodes
[sortedNodes, I] = angleSort3d(nodes2);

% compute normal vector of new face, and reverse order if face points in
% the opposite direction as plane normal
newFaceNormal = meshFaceNormals(sortedNodes, 1:length(sortedNodes));
if dot(newFaceNormal, planeNormal(plane)) < 0
    I(2:end) = I(end:-1:2);
end

% compute vertex indices of new face
newFace = I' + Nn;

% remove faces outside plane and add the new face
faces2 = {faces2{keep}, newFace};

% remove clipped nodes, and add new nodes to list of nodes
N2 = size(nodes2, 1);
nodes2 = [nodes(b, :); nodes2];

% new nodes are inside half-space by definition
b = [b; ones(N2, 1)];

% create look up table between old indices and new indices
inds = zeros(size(nodes2, 1), 1);
indb = find(b);
for i = 1:length(indb)
    inds(indb(i)) = i;
end

% update indices of faces
for f = 1:length(faces2)
    face = faces2{f};
    faces2{f} = inds(face)';
end
