function box = boundingBox3d(points)
%BOUNDINGBOX3D Bounding box of a set of 3D points.
%
%   BOX = boundingBox3d(POINTS)
%   Returns the bounding box of the set of points POINTS. POINTS is a
%   N-by-3 array containing points coordinates. The result BOX is a 1-by-6 
%   array, containing:
%   [XMIN XMAX YMIN YMAX ZMIN ZMAX]
%
%   Example
%     % Draw bounding box of a cubeoctehedron
%     [v e f] = createCubeOctahedron;
%     box3d = boundingBox3d(v);
%     figure; hold on;
%     drawMesh(v, f);
%     drawBox3d(box3d);
%     set(gcf, 'renderer', 'opengl')
%     axis([-2 2 -2 2 -2 2]);
%     view(3)
%     
%   See also 
%   boxes3d, drawBox3d

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-04-01, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

% Parse input
if isstruct(points)
    if isfield(points, 'vertices')
    points = points.vertices;
    else
        error(['If a struct is passed to boundingBox3d, it must have ' ...
            'the field ''vertices''!'])
    end
end

% compute extreme x and y values
xmin = min(points(:,1));
xmax = max(points(:,1));
ymin = min(points(:,2));
ymax = max(points(:,2));
box = [xmin xmax ymin ymax];

% process case of 3D points
if size(points, 2) > 2
    zmin = min(points(:,3));
    zmax = max(points(:,3));
    box = [xmin xmax ymin ymax zmin zmax];
end
