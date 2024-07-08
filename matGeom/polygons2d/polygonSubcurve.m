function [res, inds] = polygonSubcurve(poly, t0, t1)
%POLYGONSUBCURVE Extract a portion of a polygon.
%
%   POLY2 = polygonSubcurve(POLYGON, POS0, POS1)
%   Create a new polyline, by keeping vertices located between positions
%   POS0 and POS1, and adding points corresponding to positions POS0 and
%   POS1 if they are not already vertices.
%
%   [POLY2, INDS] = polygonSubcurve(POLYGON, POS0, POS1)
%   Also return indices of polygon vertices comprised between POS0 and
%   POS1. The array INDS may be smaller than the array POLY2.
%
%   Example
%     Nv = 100;
%     poly = circleToPolygon([30 20 15], Nv);
%     arc1 = polygonSubcurve(poly, 15, 45);
%     arc2 = polygonSubcurve(poly, 90, 10); % contains polygon endpoints
%     figure; axis equal, hold on; axis([0 50 0 50]);
%     drawPolyline(arc1, 'linewidth', 4, 'color', 'g');
%     drawPolyline(arc2, 'linewidth', 4, 'color', 'r');
%     drawPolygon(poly, 'color', 'b');
%
%   See also 
%     polygons2d, polylineSubcurve, projPointOnPolygon, polygonPoint
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2009-04-30, using Matlab 7.7.0.471 (R2008b)
% Copyright 2009-2024 INRAE - Cepia Software Platform

% number of vertices
Nv = size(poly, 1);

if t0 < t1
    % format positions
    t0 = max(t0, 0);
    t1 = min(t1, Nv);
end

% indices of extreme vertices inside subcurve
ind0 = ceil(t0)+1;
ind1 = floor(t1)+1;

% get the portion of polyline between 2 extremities
if t0 < t1
    % The result polyline does not contain the last vertex
    if ind1 <= Nv
        inds = ind0:ind1;
    else
        inds = 1;
    end
else 
    % polygon contains last vertex
    inds = [ind0:Nv 1:ind1];
end
res = poly(inds, :);

% add first point if it is not already a vertex
if t0 ~= ind0-1
    res = [polygonPoint(poly, t0); res];
end

% add last point if it is not already a vertex
if t1 ~= ind1-1
    res = [res; polygonPoint(poly, t1)];
end
    
