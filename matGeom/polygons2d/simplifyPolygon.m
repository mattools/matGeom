function [poly, keepInds] = simplifyPolygon(poly, varargin)
%SIMPLIFYPOLYGON  Douglas-Peucker simplification of a polygon.
%
%   POLY2 = simplifyPolygon(POLY, TOL)
%   Simplifies the input polygon using the Douglas-Peucker algorithm. 
%
%   Example
%     elli = [20 30 40 20 30];
%     poly = ellipseToPolygon(elli, 500);
%     poly2 = simplifyPolygon(poly, 1); % use a tolerance equal to 1.
%     figure; hold on;
%     drawEllipse(elli);
%     drawPoint(poly2, 'mo');
%
%   See also 
%   polygons2d, smoothPolygon, simplifyPolyline, resamplePolygon
%
%   References
%   http://en.wikipedia.org/wiki/Ramer-Douglas-Peucker_algorithm
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2013-03-14, using Matlab 7.9.0.529 (R2009b)
% Copyright 2013-2023 INRA - Cepia Software Platform

% call the simplifyPolyline function by ensuring the last vertex is present
poly = poly([1:end 1], :);
[poly, keepInds] = simplifyPolyline(poly, varargin{:});

% remove last vertex
poly(end, :) = [];
keepInds(end) = [];
