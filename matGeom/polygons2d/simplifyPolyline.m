function [poly2 keepInds] = simplifyPolyline(poly, tol)
%SIMPLIFYPOLYLINE Douglas-Peucker simplification of a polyline
%
%   POLY2 = simplifyPolyline(POLY, TOL)
%   Simplifies the input polyline using the Douglas-Peucker algorithm. 
%
%   Example
%     elli = [20 30 40 20 30];
%     poly = ellipseToPolygon(elli, 500);
%     poly2 = simplifyPolyline(poly, 1);
%     figure; hold on;
%     drawEllipse(elli);
%     drawPoint(poly2, 'mo');
%
%   See also
%   polygons2d, simplifyPolygon
%
%   References
%   http://en.wikipedia.org/wiki/Ramer-Douglas-Peucker_algorithm
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-05-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% number of vertices
n = size(poly, 1);

% initial call to the recursive function
keepInds = recurseSimplify(1, n);

% keep first and last vertices
keepInds = [1 keepInds n];

% create the resulting polyline
poly2 = poly(keepInds, :);


    %% Inner function that is called recursively on polyline portions
    function innerInds = recurseSimplify(i0, i1)
        
        % find the furthest vertex
        mid = furthestPointIndex(i0, i1);

        % case of no further simplification
        if isempty(mid)
            innerInds = mid;
            return;
        end
        
        % recursively subdivide each portion
        mid1 = recurseSimplify(i0, mid);
        mid2 = recurseSimplify(mid, i1);
        
        % concatenate indices of all portions
        innerInds = [mid1 mid mid2];
    end
    

    %% Inner function for finding index of furthest point in POLY
    function ind = furthestPointIndex(i0, i1)

        % for single edges, return empty result
        if i1 - i0 < 2
            ind = [];
            return;
        end
        
        % vertices of the current edge
        v0 = poly(i0, :);
        v1 = poly(i1, :);
        
        % find vertex with the greatest distance
        dists = distancePointEdge(poly(i0+1:i1-1, :), [v0 v1]);
        [maxi, ind] = max(dists);
        
        % update index only if distance criterion is verified
        if maxi > tol
            ind = i0 + ind;
        else
            ind = [];
        end
    end

end