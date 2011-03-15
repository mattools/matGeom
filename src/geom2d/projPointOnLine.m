function point = projPointOnLine(point, line)
%PROJPOINTONLINE Project of a point orthogonally onto a line
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
%   See also:
%   lines2d, points2d, isPointOnLine, linePosition
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2005.
%

%   HISTORY
%   06/08/2005 : correct bug when several points were passed as param.


% ensure input arguments have same size
if size(line, 1)==1 && size(point, 1)>1
    line = repmat(line, [size(point, 1) 1]);
end
if size(point, 1)==1 && size(line, 1)>1
    point = repmat(point, [size(line, 1) 1]);
end

% slope of line
dx = line(:, 3);
dy = line(:, 4);

% first find relative position of projection on the line,
tp = ((point(:, 2) - line(:, 2)).*dy + (point(:, 1) - line(:, 1)).*dx) ./ (dx.*dx+dy.*dy);

% convert position on line to cartesian coordinate
point = line(:,1:2) + [tp tp].*[dx dy];
