function rev = reversePolyline(poly)
%REVERSEPOLYLINE Reverse a polyline, by iterating vertices from the end
%
%   POLY2 = reversePolyline(POLY)
%   POLY2 has same vertices as POLY, but POLY2(i,:) is the same as
%   POLY(END-i+1,:).
%
%   Example
%   reversePolyline
%
%   See also
%   polygons2d, reversePolygon
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-30,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

rev = poly(end:-1:1, :);