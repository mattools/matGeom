function res = polygonSubcurve(poly, t0, t1)
%POLYGONSUBCURVE Extract a portion of a polygon
%
%   POLY2 = polygonSubcurve(POLYGON, POS0, POS1)
%   Create a new polyline, by keeping vertices located between positions
%   POS0 and POS1, and adding points corresponding to positions POS0 and
%   POS1 if they are not already vertices.
%
%   Example
%   Nv = 100;
%   poly = circleAsPolygon([10 20 30], Nv);
%   poly2 = polygonSubcurve(poly, 15, 65);
%   drawCurve(poly2);
%
%   See also
%   polygons2d, polylineSubcurve
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
    t1 = min(t1, Nv);
end

% indices of extreme vertices inside subcurve
ind0 = ceil(t0)+1;
ind1 = floor(t1)+1;

% get the portion of polyline between 2 extremities
if t0<t1
    if ind1<=Nv
        res = poly(ind0:ind1, :);
    else
        res = poly(1, :);
    end
else 
    res = poly([ind0:end 1:ind1], :);
end

% add first point if it is not already a vertex
if t0~=ind0-1
    res = [polygonPoint(poly, t0); res];
end

% add last point if it is not already a vertex
if t1~=ind1-1
    res = [res; polygonPoint(poly, t1)];
end
    
