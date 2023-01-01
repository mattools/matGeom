function [centroid, area, Sx, Sy] = polygonCentroid(varargin)
%POLYGONCENTROID Computes the centroid (center of mass) of a polygon.
%
%   CENTROID = polygonCentroid(POLY)
%   CENTROID = polygonCentroid(PTX, PTY)
%   Computes center of mass of a polygon defined by POLY. POLY is a N-by-2
%   array of double containing coordinates of vertices.
%
%   [CENTROID, AREA] = polygonCentroid(POLY)
%   Also returns the (signed) area of the polygon. 
%
%   Example
%     % Draws the centroid of a paper hen
%     x = [0 10 20  0 -10 -20 -10 -10  0];
%     y = [0  0 10 10  20  10  10  0 -10];
%     poly = [x' y'];
%     centro = polygonCentroid(poly);
%     drawPolygon(poly);
%     hold on; axis equal;
%     drawPoint(centro, 'bo');
% 
%   References
%     Algorithm adapted from P. Bourke's web page.
%
%   See also 
%     polygons2d, polygonArea, polygonSecondAreaMoments, drawPolygon
%     polylineCentroid, centroid

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2004-05-05
% Copyright 2004-2022

% parse input arguments
if nargin == 1
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
elseif nargin == 2
    px = varargin{1};
    py = varargin{2};
end

poly = parsePolygon([px, py], 'repetition');
px = poly(:,1);
py = poly(:,2);

% vertex indices
N = length(px);
iNext = [2:N 1];

% compute cross products
common = px .* py(iNext) - px(iNext) .* py;
Sx = 1/6*sum((py + py(iNext)) .* common);
Sy = 1/6*sum((px + px(iNext)) .* common);

% area and centroid
area = sum(common) / 2;
centroid = [Sy Sx] / area;
