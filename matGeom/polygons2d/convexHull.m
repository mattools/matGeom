function [hull, inds] = convexHull(points, varargin)
%CONVEXHULL Convex hull of a set of points.
%
%   POLY = convexHull(POINTS)
%   Computes the convex hull of the set of points POINTS. This function is
%   mainly a wrapper to the convhull function, that format the result to a
%   polygon.
%
%   [POLY, INDS] = convexHull(POINTS)
%   Also returns the indices of convex hull vertices within the original
%   array of points.
%
%   ... = convexHull(POINTS, 'simplify', BOOL)
%   specifies the 'simplify' option use dfor calling convhull. By default,
%   the convexHull functions uses simplify equals to TRUE (contrary to the
%   convhull function), resulting in a more simple convex polygon.
%   
%   
%   Example
%     % Draws the convex hull of a set of random points
%     pts = rand(30,2);
%     drawPoint(pts, '.');
%     hull = convexHull(pts);
%     hold on; 
%     drawPolygon(hull);
%
%     % Draws the convex hull of a paper hen
%     x = [0 10 20  0 -10 -20 -10 -10  0];
%     y = [0  0 10 10  20  10  10  0 -10];
%     poly = [x' y'];
%     hull = convexHull(poly);
%     figure; drawPolygon(poly);
%     hold on; axis equal;
%     drawPolygon(hull, 'm');
%
%   See also 
%   polygons2d, convhull
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-04-08, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

% checkup on array size
if size(points, 1) < 3
    hull = points;
    inds = 1:size(points, 1);
    return;
end

% parse simplify option
simplify = true;
if nargin > 2 && strcmpi(varargin{1}, 'simplify')
    simplify = varargin{2};
end

% compute convex hull by calling the 'convhull' function
inds = convhull(points(:,1), points(:,2), 'simplify', simplify);
hull = points(inds, :);
