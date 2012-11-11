function [centroid area] = polygonCentroid(varargin)
%POLYGONCENTROID Compute the centroid (center of mass) of a polygon
%
%   CENTROID = polygonCentroid(POLY)
%   CENTROID = polygonCentroid(PTX, PTY)
%   Computes center of mass of a polygon defined by POLY. POLY is a N-by-2
%   array of double containing coordinates of vertices.
%
%   [CENTROID AREA] = polygonCentroid(POLY)
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
%   algo adapted from P. Bourke web page
%
%   See also:
%   polygons2d, polygonArea, drawPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 05/05/2004.
%

% Algorithme P. Bourke, vectorized version

% HISTORY
% 2012.02.24 vectorize code


% parse input arguments
if nargin == 1
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
elseif nargin == 2
    px = varargin{1};
    py = varargin{2};
end

% vertex indices
N = length(px);
iNext = [2:N 1];

% compute cross products
common = px .* py(iNext) - px(iNext) .* py;
sx = sum((px + px(iNext)) .* common);
sy = sum((py + py(iNext)) .* common);

% area and centroid
area = sum(common) / 2;
centroid = [sx sy] / 6 / area;
