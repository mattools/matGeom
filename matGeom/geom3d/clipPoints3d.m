function varargout = clipPoints3d(points, shape, varargin)
%CLIPPOINTS3D Clip a set of points by a box or other 3d shapes.
%
%   CLIP = clipPoints3d(POINTS, BOX);
%   Returns the set of points which are located inside of the box BOX.
%
%   [CLIP, IND] = clipPoints3d(POINTS, BOX);
%   Also returns the indices of clipped points.
%   
%   ... = clipPoints3d(..., 'shape', 'sphere') Specify the shape.
%   Default is 'box'. But it is also possible to use 'sphere' or 'plane'.
%   
%   ... = clipPoints3d(..., 'inside', false) returns the set of  
%   points outside the shape instead of inside.
%
%   See also
%   points3d, boxes3d, spheres
%

% ------
% Author: David Legland, oqilipo
% e-mail: david.legland@inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA Nantes - MIAJ Jouy-en-Josas.

parser = inputParser;
validStrings = {'box', 'sphere', 'plane'};
addParameter(parser, 'shape', 'box', @(x) any(validatestring(x, validStrings)));
addParameter(parser, 'inside', true, @islogical);
parse(parser,varargin{:});

switch parser.Results.shape
    case 'box'
        LI = clipPointsByBox(points, shape);
    case 'plane'
        LI = clipPointsByPlane(points, shape);
    case 'sphere'
        LI = clipPointsBySphere(points, shape);
end

if parser.Results.inside
    % keep points inside the shape
    ind = find(LI);
else
    % keep points outside the shape
    ind = find(~LI);
end
points = points(ind, :);

% process output arguments
varargout{1} = points;
if nargout == 2
    varargout{2} = ind;
end

    function LI = clipPointsByBox(points, box)
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
        
        LI = xOk & yOk & zOk;
    end

    function LI = clipPointsByPlane(points, plane)
        % points inside and on the surface of the sphere
        LI = isBelowPlane(points, plane);
    end

    function LI = clipPointsBySphere(points, sphere)
        % points inside and on the surface of the sphere
        LI = distancePoints3d(points, sphere(1:3)) <= sphere(4);
    end

end

