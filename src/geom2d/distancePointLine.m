function dist = distancePointLine(point, line)
%DISTANCEPOINTLINE Minimum distance between a point and a line
%
%   D = distancePointLine(POINT, LINE)
%   Return the euclidean distance between line LINE and point POINT. 
%
%   LINE has the form : [x0 y0 dx dy], and POINT is [x y].
%
%   If LINE is N-by-4 array, result is N-by-1 array computes for each line.
%
%   If POINT is N-by-2, then result is computed for each point.
%
%   If both POINT and LINE are array, result is N-by-1, computed for each
%   corresponding point and line.
%
%
%   See also:
%   lines2d, points2d, distancePoints, distancePointEdge
%
%   
%   ---------
%   author : David Legland 
%   INRA - CEPIA URPOI - MIA MathCell
%   created the 24/06/2005
%

%   HISTORY :


if size(line, 1)==1 && size(point, 1)>1
    line = repmat(line, [size(point, 1) 1]);
end

if size(point, 1)==1 && size(line, 1)>1
    point = repmat(point, [size(line, 1) 1]);
end

dx = line(:, 3);
dy = line(:, 4);

% compute position of points projected on line
tp = ((point(:, 2) - line(:, 2)).*dy + (point(:, 1) - line(:, 1)).*dx) ./ (dx.*dx+dy.*dy);
p0 = line(:, 1:2) + [tp tp].*[dx dy];


% compute distances between points and their projections
dx = point - p0;
dist  = sqrt(sum(dx.*dx, 2));



