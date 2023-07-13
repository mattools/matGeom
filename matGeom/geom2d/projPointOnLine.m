function point = projPointOnLine(point, line)
%PROJPOINTONLINE Project a point orthogonally onto a line.
%
%   PT2 = projPointOnLine(PT, LINE).
%   Computes the (orthogonal) projection of point PT onto the line LINE.
%   
%   Function works also for multiple points and lines. In this case, it
%   returns multiple points.
%   Point PT1 is a [N*2] array, and LINE is a [N*4] array (see createLine
%   for details). Result PT2 is a [N*2] array, containing coordinates of
%   orthogonal projections of PT1 onto lines LINE.
%
%   Example
%     line = [0 2  2 1];
%     projPointOnLine([3 1], line)
%     ans = 
%          2   3
%
%   See also 
%     lines2d, points2d, isPointOnLine, linePosition, projPointOnEllipse
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2005-07-04
% Copyright 2005-2023 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% parse input arguments
p = inputParser;
addRequired(p, 'point', @(x)validateattributes(x,{'numeric'},...
    {'size',[nan, 2],'nonnan','real','finite'}))
addRequired(p, 'line', @(x)validateattributes(x,{'numeric'},...
    {'size',[nan, 4],'nonnan','real','finite'}))
parse(p, point, line)

% direction vector of the line
vx = line(:, 3);
vy = line(:, 4);

% difference of point with line origin
dx = point(:,1) - line(:,1);
dy = point(:,2) - line(:,2);

% Position of projection on line, using dot product
tp = (dx .* vx + dy .* vy ) ./ (vx .* vx + vy .* vy);

% convert position on line to cartesian coordinates
point = [line(:,1) + tp .* vx, line(:,2) + tp .* vy];
