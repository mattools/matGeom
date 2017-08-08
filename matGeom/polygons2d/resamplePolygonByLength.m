function poly2 = resamplePolygonByLength(poly, step)
%RESAMPLEPOLYGONBYLENGTH  Resample a polygon with a fixed sampling step
%
%   RES = resamplePolygon(POLY, STEP)
%   Resample the input polygon POLY by distributing new vertices on the
%   original polygon such that the (curvilinear) distance between the new
%   vertices is approximately equal to STEP. 
%
%   Example
%     % creates a polygon from an ellipse
%     elli = [20 30 40 20 30];
%     poly = ellipseToPolygon(elli, 500);
%     figure; drawPolygon(poly, 'b');
%     poly2 = resamplePolygonByLength(poly, 10);
%     hold on; 
%     drawPolygon(poly2, 'm');
%     drawPoint(poly2, 'mo');
%     axis equal; axis([-20 60 0 60]);
%     legend('Original polygon', 'Resampled polygon', 'Location', 'NorthWest');
%
%   See also
%     polygons2d, simplifyPolygon, resamplePolygon,
%     resamplePolylineByLength
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-12-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

poly2 = resamplePolylineByLength(poly([1:end 1],:), step);
poly2(end, :) = [];
