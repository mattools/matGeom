function varargout = drawBSplinePolygon(poly, varargin)
%DRAWBSPLINEPOLYGON  Draw a smooth curve by interpolating polygon vertices.
%
%   drawBSplinePolygon(POLY)
%   POLY is a N-by-2 numeric array containing vertex coordinates of the
%   control polygon. 
%
%   Example
%     poly = [10 10; 30 10; 40 20;30 40;10 30];
%     figure; hold on; axis equal; axis([0 50 0 50]);
%     drawPolyline(poly);
%     drawBSplinePolygon(poly, 'r');
%
%   See also
%     BSplinePolygon, drawBezierCurve
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-04-01,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE.

% number of subdivisions per edge
nDiv = 20;

curve = BSplinePolygon(poly, nDiv);

h = drawPolygon(curve, varargin{:});

if nargout > 0
    varargout{1} = h;
end