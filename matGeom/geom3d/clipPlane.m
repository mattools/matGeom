function poly = clipPlane(plane, box)
%CLIPPLANE Compute the 3D polygon representing a clipped plane.
%
%   POLY = clipPlane(PLANE, BOUNDS)
%   Computes the vertices of the 3D polygon that represents the result of
%   the clipping of the plane by the given BOUNDS.
%   PLANE is given as [X0 Y0 Z0  DX1 DY1 DZ1   DX2 DY2 DZ2], 
%   BOUNDS is given as [XMIN XMAX  YMIN YMAX  ZMIN ZMAX].
%   The result POLY is given as N-by-3 numeric array representing the
%   coordinates of the polygon, or an emptyarray if the plane lies totally
%   outside of the bounds.
%
%
%   Example
%     plane = [5 5 5  1 0 0  0 1 0];
%     bounds = [0 10  0 10  0 10];
%     poly = clipPlane(plane, bounds)
%     poly =
%          0     0     5
%         10     0     5
%         10    10     5
%          0    10     5
%
%   See also 
%     planes3d, createPlane, drawPlane3d
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2021-11-09, using Matlab 9.10.0.1684407 (R2021a) Update 3
% Copyright 2021-2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% retrieve min/max coords
xmin = box(1);
xmax = box(2);
ymin = box(3);
ymax = box(4);
zmin = box(5);
zmax = box(6);

% create lines corresponding to the edges of the bounding box
lineX00 = [xmin ymin zmin 1 0 0];
lineX01 = [xmin ymin zmax 1 0 0];
lineX10 = [xmin ymax zmin 1 0 0];
lineX11 = [xmin ymax zmax 1 0 0];

lineY00 = [xmin ymin zmin 0 1 0];
lineY01 = [xmin ymin zmax 0 1 0];
lineY10 = [xmax ymin zmin 0 1 0];
lineY11 = [xmax ymin zmax 0 1 0];

lineZ00 = [xmin ymin zmin 0 0 1];
lineZ01 = [xmin ymax zmin 0 0 1];
lineZ10 = [xmax ymin zmin 0 0 1];
lineZ11 = [xmax ymax zmin 0 0 1];

% compute intersection point with each line
piX00 = intersectLinePlane(lineX00, plane);
piX01 = intersectLinePlane(lineX01, plane);
piX10 = intersectLinePlane(lineX10, plane);
piX11 = intersectLinePlane(lineX11, plane);
piY00 = intersectLinePlane(lineY00, plane);
piY01 = intersectLinePlane(lineY01, plane);
piY10 = intersectLinePlane(lineY10, plane);
piY11 = intersectLinePlane(lineY11, plane);
piZ00 = intersectLinePlane(lineZ00, plane);
piZ01 = intersectLinePlane(lineZ01, plane);
piZ10 = intersectLinePlane(lineZ10, plane);
piZ11 = intersectLinePlane(lineZ11, plane);

% concatenate points into one array
points = [...
    piX00;piX01;piX10;piX11; ...
    piY00;piY01;piY10;piY11; ...
    piZ00;piZ01;piZ10;piZ11;];

% check validity: keep only points inside window (with tolerance)
ac = sqrt (eps);
ivx = points(:,1) >= xmin-ac & points(:,1) <= xmax+ac;
ivy = points(:,2) >= ymin-ac & points(:,2) <= ymax+ac;
ivz = points(:,3) >= zmin-ac & points(:,3) <= zmax+ac;
valid = ivx & ivy & ivz;
points = unique(points(valid, :), 'rows');

% If there is no intersection point, escape.
if size(points, 1) < 3
    poly = [];
    return;
end

% the two spanning lines of the plane
d1 = plane(:, [1:3 4:6]);
d2 = plane(:, [1:3 7:9]);

% position of intersection points in plane coordinates
u1 = linePosition3d(points, d1);
u2 = linePosition3d(points, d2);

% reorder vertices in the correct order
inds = convhull(u1, u2);
inds = inds(1:end-1);

% return the set of points that compose the polygon
poly = points(inds, :);
