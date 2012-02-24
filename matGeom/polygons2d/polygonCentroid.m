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
%   See also:
%   polygons2d, polygonArea, drawPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 05/05/2004.
%

% HISTORY
% 2012.02.24 vectorize code

if nargin==1
    var = varargin{1};
    px = var(:,1);
    py = var(:,2);
elseif nargin==2
    px = varargin{1};
    py = varargin{2};
end

% Algorithme P. Bourke, vectorized version
N = length(px);
iNext = [2:N 1];
common = (px .* py(iNext) - px(iNext) .* py);
sx = sum((px + px(iNext)) .* common);
sy = sum((py + py(iNext)) .* common);

area = sum(common) / 2;
centroid = [sx sy] / 6 / area;