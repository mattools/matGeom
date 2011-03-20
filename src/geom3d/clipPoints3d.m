function varargout = clipPoints3d(points, box)
%CLIPPOINTS3D Clip a set of points by a box
%
%   CLIP = clipPoints3d(POINTS, BOX);
%   Returns the set of points which are located inside of the box BOX.
%
%   [CLIP IND] = clipPoints2d(POINTS, BOX);
%   Also returns the indices of clipepd points.
%
%   See also
%   points3d, boxes3d
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% get bounding box limits
xmin = box(1);
xmax = box(2);
ymin = box(3);
ymax = box(4);
zmin = box(5);
zmax = box(6);

% compute indices of points inside visible area
xOk = points(:,1) >= xmin & points(:,1) <= xmax;
yOk = points(:,2) >= ymin & points(:,2) <= ymax;
zOk = points(:,3) >= zmin & points(:,3) <= zmax;

% keep only points inside box
ind = find(xOk & yOk & zOk);
points = points(ind, :);

% process output arguments
varargout{1} = points;
if nargout == 2
    varargout{2} = ind;
end
