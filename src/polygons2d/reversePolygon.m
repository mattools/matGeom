function rev = reversePolygon(poly)
%REVERSEPOLYGON Reverse a polygon, by iterating vertices from the end
%
%   POLY2 = reversePolygon(POLY)
%   POLY2 has same vertices as POLY, but in different order. The first
%   vertex of the polygon is still the same.
%
%   Example
%   reversePolygon
%
%   See also
%   polygons2d, reversePolyline
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-30,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

rev = poly([1 end:-1:2], :);