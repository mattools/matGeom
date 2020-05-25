function edge = clipRay3d(ray, box)
% Clip a 3D ray with a box and return a 3D edge.
%
%   EDGE = clipRay3d(RAY, BOX)
%   Clips the ray RAY with the bounds given in BOX, and returns the
%   corresponding edge. 
%   RAY is given as origin + direction vector: [X0 Y0 Z0  DX DY DZ]
%   BOX is given as  [XMIN XMAX  YMIN YMAX  ZMIN ZMAX].
%   The result EDGE is given as [X1 Y1 Z1  X2 Y2 Z2].
%
%   Example
%     % generate 50 random 3D rays
%     origin = [29 28 27];
%     v = rand(50, 3);
%     v = v - centroid(v);
%     ray = [repmat(origin, size(v,1),1) v];
%     % clip the rays with a 3D box
%     box = [10 40 10 40 10 40];
%     edges = clipRay3d(ray, box);
%     % draw the resulting 3D edges
%     figure; axis equal; axis([0 50 0 50 0 50]); hold on; view(3);
%     drawBox3d(box);
%     drawEdge3d(edges, 'g');
%
%   See also
%     clipLine3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-05-25,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.

% get box limits
xmin = box(1); xmax = box(2);
ymin = box(3); ymax = box(4);
zmin = box(5); zmax = box(6);

% extreme corners of the box
p000 = [xmin ymin zmin];
p111 = [xmax ymax zmax];

% main vectors
ex   = [1 0 0];
ey   = [0 1 0];
ez   = [0 0 1];

% box faces parallel to Oxy
planeZ0 = [p000 ex ey];
planeZ1 = [p111 ex ey];

% box faces parallel to Oxz
planeY0 = [p000 ex ez];
planeY1 = [p111 ex ez];

% box faces parallel to Oyz
planeX0 = [p000 ey ez];
planeX1 = [p111 ey ez];

% number of rays
nRays = size(ray, 1);

% allocate memory for result
edge = NaN * ones(nRays, 6);

% iterate over rays to clip
for i = 1:nRays
    % compute intersection point of supporting line with each clipping plane
    ipZ0 = intersectLinePlane(ray(i,:), planeZ0);
    ipZ1 = intersectLinePlane(ray(i,:), planeZ1);
    ipY0 = intersectLinePlane(ray(i,:), planeY0);
    ipY1 = intersectLinePlane(ray(i,:), planeY1);
    ipX1 = intersectLinePlane(ray(i,:), planeX1);
    ipX0 = intersectLinePlane(ray(i,:), planeX0);

    % concatenate resulting points
    points  = [ipX0;ipX1;ipY0;ipY1;ipZ0;ipZ1];

    % compute position of each point on the ray
    pos     = linePosition3d(points, ray(i,:));

    % keep only defined points
    ind     = find(~isnan(pos));
    pos     = pos(ind);
    points  = points(ind,:);

    if isempty(pos)
        continue;
    end
    
    % sort points with respect to their position
    [pos, ind] = sort(pos);
    points = points(ind, :);

    % keep median points wrt to position. These points define the limit of
    % the clipped edge.
    nv  = length(ind)/2;
    pos = pos([nv, nv+1]);
    points = points([nv nv+1], :);
    
    % case of second edge extremity before ray origin
    if pos(2) < 0
        continue;
    end

    % case of first edge extremity before ray origin
    if pos(1) < 0
        points(1,1:3) = ray(i,1:3);
    end
    
    % create resulting edge.
    edge(i,:)   = [points(1, :) points(2, :)];
end

% check that middle point of the edge is contained in the box
midX = mean(edge(:, [1 4]), 2);
xOk  = xmin <= midX & midX <= xmax;
midY = mean(edge(:, [2 5]), 2);
yOk  = ymin <= midY & midY <= ymax;
midZ = mean(edge(:, [3 6]), 2);
zOk  = zmin <= midZ & midZ <= zmax;

% if one of the bounding condition is not met, set edge to NaN
edge (~(xOk & yOk & zOk), :) = NaN;
