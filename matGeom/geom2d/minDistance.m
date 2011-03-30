function [dist, varargout] = minDistance(p, curve)
%MINDISTANCE compute minimum distance between a point and a set of points
%
%   Deprecated: use minDistancePoints instead
%
%   usage:
%   d = MINDISTANCE(P, POINTS)
%   POINTS is a [N*2] array of points, and P a single point. function
%   return the minimum distance between P and one of the points.
%
%   Also works for several points in P. In this case, return minimum
%   distance between each element of P and all element of POINTS. d is the
%   same length than P.
%
%   [d, i] = MINDISTANCE(P, POINTS)
%   also return index of closest point in POINTS.
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 23/02/2004.
%

%   HISTORY :
%   18/03/2004 : can also return index of closest point
%   08/04/2004 : return vertical array when input multiple points

dist = inf;

for i=1:size(p, 1)
    dx = curve(:,1)-p(i,1);
    dy = curve(:,2)-p(i,2);
    [dist(i,1), ind(i,1)] = min(sqrt(dx.*dx + dy.*dy));
end

if nargout>1
    varargout{1} = ind;
end