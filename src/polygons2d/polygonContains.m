function varargout = polygonContains(poly, point)
%POLYGONCONTAINS Test if a point is contained in a multiply connected polygon
%
%   B = polygonContains(POLYGON, POINT);
%   Returns TRUE if the (possibly multi-connected) polygon POLYGON contains
%   the point(s) given by POINT.
%   This is an extension of the Matlab function inpolygon for the case of
%   polygons with holes.
%
%   Example
%   POLY = [0 0; 10 0;10 10;0 10;NaN NaN;3 3;3 7;7 7;7 3];
%   PT = [5 1;5 4];
%   polygonContains(POLY, PT);
%   ans =
%        1
%        0
%
%   See also
%   polygons2d, 
%   inpolygon
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-10-11,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


% transform as a cell array of simple polygons
polygons = splitPolygons(poly);
N = length(polygons);
Np = size(point, 1);

% compute orientation of polygon, and format to have Np*N matrix
ccw = polygonArea(polygons)>0;
ccw = repmat(ccw', Np, 1);

% test if point inside each polygon
in = false(size(point, 1), N);
for i=1:N
    poly = polygons{i};
    in(:, i) = inpolygon(point(:,1), point(:,2), poly(:,1), poly(:,2));
end

% count polygons containing point, weighted by polygon orientation
res = sum(in.*(ccw==1) - in.*(ccw==0), 2);

varargout{1} = res;
