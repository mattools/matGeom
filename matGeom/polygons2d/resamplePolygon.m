function poly2 = resamplePolygon(poly, n)
%RESAMPLEPOLYGON  Distribute N points equally spaced on a polygon
%
%   output = resamplePolygon(input)
%
%   Example
%     poly = [0 0;20 0;20 10;0 10];
%     figure; drawPolygon(poly, 'b');
%     % draw vertices of original polygon
%     hold on; drawPoint(poly, 'ks');
%     % sub-sample the polygon
%     poly2 = resamplePolygon(poly, 24);
%     drawPolygon(poly2, 'bx');
%     axis equal; axis([-10 30 -10 20]);
%
%
%   See also
%     polygons2d, drawPolygon, resamplePolyline
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

poly2 = resamplePolyline(poly([1:end 1],:), n+1);
poly2(end, :) = [];
