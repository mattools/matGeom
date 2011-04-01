function res = polylineSubcurve(poly, t0, t1)
%POLYLINESUBCURVE Extract a portion of a polyline
%
%   POLY2 = polylineSubcurve(POLYLINE, POS0, POS1)
%   Create a new polyline, by keeping vertices located between positions
%   POS0 and POS1, and adding points corresponding to positions POS0 and
%   POS1 if they are not already vertices.
%
%   Example
%   Nv = 100;
%   poly = circleAsPolygon([10 20 30], Nv);
%   poly2 = polylineSubcurve(poly, 15, 65);
%   drawCurve(poly2);
%
%   See also
%   polygons2d, polygonSubCurve
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-30,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

% number of vertices
Nv = size(poly, 1);

if t0<t1
    % format positions
    t0 = max(t0, 0);
    t1 = min(t1, Nv-1);
end

% indices of extreme vertices inside subcurve
ind0 = ceil(t0)+1;
ind1 = floor(t1)+1;

% get the portion of polyline between 2 extremities
if t0<t1
    res = poly(ind0:ind1, :);
else
    res = poly([ind0:end 1:ind1], :);
end

% add first point if it is not already a vertex
if t0 ~= ind0-1
    res = [polylinePoint(poly, t0); res];
end

% add last point if it is not already a vertex
if t1~=ind1-1
    res = [res; polylinePoint(poly, t1)];
end
    
