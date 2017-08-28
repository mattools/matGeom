function box = boundingBox(points)
%BOUNDINGBOX Bounding box of a set of points
%
%   BOX = boundingBox(POINTS)
%   Returns the bounding box of the set of points POINTS. POINTS can be
%   either a N-by-2 or N-by-3 array. The result BOX is a 1-by-4 or 1-by-6
%   array, containing:
%   [XMIN XMAX YMIN YMAX] (2D point sets)
%   [XMIN XMAX YMIN YMAX ZMIN ZMAX] (3D point sets)
%
%   Example
%   % Draw the bounding box of a set of random points
%     points = rand(30, 2);
%     figure; hold on;
%     drawPoint(points, '.');
%     box = boundingBox(points);
%     drawBox(box, 'r');
%
%   % Draw bounding box of a cubeoctehedron
%     [v e f] = createCubeOctahedron;
%     box3d = boundingBox(v);
%     figure; hold on;
%     drawMesh(v, f);
%     drawBox3d(box3d);
%     set(gcf, 'renderer', 'opengl')
%     axis([-2 2 -2 2 -2 2]);
%     view(3)
%     
%   See also
%   polygonBounds, drawBox
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-04-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% HISTORY
% 2011-04-08 add example
% 2011-12-09 rename to boundingBox

% compute extreme x and y values
xmin = min(points(:,1));
xmax = max(points(:,1));
ymin = min(points(:,2));
ymax = max(points(:,2));

if size(points, 2) > 2
    % process case of 3D points
    zmin = min(points(:,3));
    zmax = max(points(:,3));
    
    % format as box 3D data structure
    box = [xmin xmax ymin ymax zmin zmax];
else
    % format as box data structure
    box = [xmin xmax ymin ymax];
end
