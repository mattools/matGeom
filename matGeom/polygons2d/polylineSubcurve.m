function [res, inds] = polylineSubcurve(poly, t0, t1)
%POLYLINESUBCURVE Extract a portion of a polyline.
%
%   POLY2 = polylineSubcurve(POLYLINE, POS0, POS1)
%   Create a new polyline, by keeping vertices located between positions
%   POS0 and POS1, and adding points corresponding to positions POS0 and
%   POS1 if they are not already vertices.
%
%   [POLY2, INDS] = polylineSubcurve(POLYLINE, POS0, POS1)
%   Also returns the indices of the original polyline that were selected.
%   The size of the array INDS may be smaller than the array POLY, due to
%   the addition of new vertices at the extremities.
%
%   Example
%     Nv = 100;
%     poly = circleAsPolygon([10 20 30], Nv);
%     poly2 = polylineSubcurve(poly, 15, 65);
%     drawCurve(poly2);
%
%   See also 
%     polygons2d, polygonSubCurve
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2009-04-30, using Matlab 7.7.0.471 (R2008b)
% Copyright 2009-2023 INRAE - Cepia Software Platform

% number of vertices
Nv = size(poly, 1);

if t0 < t1
    % format positions
    t0 = max(t0, 0);
    t1 = min(t1, Nv-1);
end

% indices of extreme vertices inside subcurve
ind0 = ceil(t0)+1;
ind1 = floor(t1)+1;

% get the portion of polyline between 2 extremities
if t0 < t1
    inds = ind0:ind1;
else
    inds = [ind0:Nv 1:ind1];
end

res = poly(inds, :);

% add first point if it is not already a vertex
if t0 ~= ind0-1
    res = [polylinePoint(poly, t0); res];
end

% add last point if it is not already a vertex
if t1 ~= ind1-1
    res = [res; polylinePoint(poly, t1)];
end
    
