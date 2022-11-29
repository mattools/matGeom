function [dist, varargout] = minDistance(p, curve)
%MINDISTANCE compute minimum distance between a point and a set of points.
%
%   Deprecated: use minDistancePoints instead
%
%   usage:
%   D = minDistance(P, POINTS)
%   POINTS is a N-by-2 array of points, and P a single point. The function
%   returns the minimum distance between P and one of the points.
%
%   Also works for several points in P. In this case, returns the minimum
%   distance between each element of P and all element of POINTS. D has the
%   same length as P.
%
%   [D, IND] = minDistance(P, POINTS)
%   also return index of closest point in POINTS.
%
%

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-02-23
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

% allocate memory for result
nPoints = size(p, 1);
dist = zeros(nPoints, 1);
ind  = zeros(nPoints, 1);

% iterate over input points
for i = 1:size(p, 1)
    dx = curve(:,1) - p(i,1);
    dy = curve(:,2) - p(i,2);
    [dist(i,1), ind(i,1)] = min(hypot(dx, dy));
end

if nargout > 1
    varargout{1} = ind;
end
