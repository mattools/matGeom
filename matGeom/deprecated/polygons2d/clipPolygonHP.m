function varargout = clipPolygonHP(poly, line, varargin)
%CLIPPOLYGONHP Clip a polygon with a half-plane defined by a directed line.
%
%   POLY2 = clipPolygonHP(POLY, LINE)
%   POLY is a [Nx2] array of points, and LINE is given as [x0 y0 dx dy].
%   The result POLY2 is also an array of points, sometimes smaller than
%   poly, and that can be [0x2] (empty polygon). POLY2 contains the part of
%   POLY on the left side of the directed line.
%   
%   [POLY_L, POLY_R] = clipPolygonHP(POLY, LINE, 'method', 'polyshape')
%   Uses MATLAB polyshape objects and functions to clip the polygon by the
%   line. Returns the right part POLY_R in addition to the left part 
%   POLY_L in the polygon cell format.
%
%   Example
%     line = [0.4 0 1 1];
%     r = [2.5, 2, 1];
%     poly = flipud(circleToPolygon([0 0 r(1)], round(2*pi*r(1))));
%     poly2 = clipPolygonHP(poly, line);
%     figure('color','w','numbertitle','off','name','Method: legland')
%     axis equal tight; hold on; xlabel('x'); ylabel('y')
%     fillPolygon(poly2)
%     poly2_centroid = polygonCentroid(poly2);
%     drawLabels(poly2_centroid,'L ','HorizontalAlignment','Right')
%     scatter(poly2_centroid(1), poly2_centroid(2),[],'k','filled')
%     midCircle = circleToPolygon([0 0 r(2)], round(2*pi*r(2)));
%     innerCircle = flipud(circleToPolygon([0 0 r(3)], round(2*pi*r(3))));
%     poly = {poly, midCircle, innerCircle};
%     clipPolygonHP(poly, line, 'method','polyshape','debug',1);
%
%   See also 
%   clipPolygon

% ------
% Author: David Legland, oqilipo
% E-mail: david.legland@inrae.fr
% Created: 2005-07-31
% Copyright 2005-2023 INRA - Cepia Software Platform

% deprecation warning
warning('matGeom:polygons2d:deprecated', ...
    '''clipPolygonHP'' is deprecated, use ''clipPolygonByLine'' instead');

varargout{1:nargout} = clipPolygonByLine(poly, line, varargin{:});
