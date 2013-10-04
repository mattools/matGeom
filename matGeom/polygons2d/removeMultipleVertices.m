function poly = removeMultipleVertices(poly, varargin)
%REMOVEMULTIPLEVERTICES Remove multiple vertices of a polygon or polyline
%
%   POLY2 = removeMultipleVertices(POLY, EPS)
%   Remove adjacent vertices that are closer than the distance EPS to each
%   other and merge them to a unique vertex.
%
%   POLY2 = removeMultipleVertices(POLY, EPS, CLOSED)
%   If CLOSED is true, also check if first and last vertices need to be
%   merged. If not specified, CLOSED is false.
%
%   Example
%     poly = [10 10; 20 10;20 10;20 20;10 20; 10 10];
%     poly2 = removeMultipleVertices(poly, true);
%     size(poly2, 1)
%     ans = 
%         4
%
%   See also
%   polygons2d, mergeClosePoints

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-10-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

% default values
eps = 1e-14;
closed = false;

% process input options
while ~isempty(varargin)
    var = varargin{1};
    if islogical(var)
        closed = var;
    elseif isnumeric(var)
        eps = var;
    else
        error('MatGeom:removeMultipleVertices:IllegalArgument',...
            'Can not interpret optional argument');
    end
    varargin(1) = [];
end

% distance between adjacent vertices
dist = sqrt(sum((poly(2:end,:) - poly(1:end-1,:)).^2, 2));
multi = dist < eps;

% process extremities
if closed
    dist = sqrt(sum((poly(end,:) - poly(1,:)).^2, 2));
    multi = [multi ; dist < eps];
else
    multi = [mutli ; 0];
end

% remove multiple vertices
poly(multi, :) = [];

