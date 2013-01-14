function pos = linePosition(point, line, varargin)
%LINEPOSITION Position of a point on a line
%
%   POS = linePosition(POINT, LINE);
%   Computes position of point POINT on the line LINE, relative to origin
%   point and direction vector of the line.
%   LINE has the form [x0 y0 dx dy],
%   POINT has the form [x y], and is assumed to belong to line.
%
%   POS = linePosition(POINT, LINES);
%   If LINES is an array of NL lines, return NL positions, corresponding to
%   each line.
%
%   POS = linePosition(POINTS, LINE);
%   If POINTS is an array of NP points, return NP positions, corresponding
%   to each point.
%
%   POS = linePosition(POINTS, LINES);
%   If POINTS is an array of NP points and LINES is an array of NL lines,
%   return an array of [NP NL] position, corresponding to each couple
%   point-line.
%
%   POS = linePosition(POINTS, LINES, 'diag');
%   When POINTS and LINES have the same number of rows, computes positions
%   only for couples POINTS(i,:) and LINES(i,:). The result POS is a column
%   vector with as many rows as the number of points/lines.
%
%
%   Example
%   line = createLine([10 30], [30 90]);
%   linePosition([20 60], line)
%   ans =
%       .5
%
%   See also:
%   lines2d, createLine, projPointOnLine, isPointOnLine
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 25/05/2004.
%

%   HISTORY
%   2005-07-07 manage multiple input
%   2011-06-15 avoid the use of repmat when possible
%   2012-10-24 rewrite using bsxfun
%   2012-11-22 add support for the diag option


if ~isempty(varargin) && ischar(varargin{1}) && strcmpi(varargin{1}, 'diag')
    % In the case of 'diag' option, use direct correspondence between
    % points and lines
    
    % check input have same size
    np = size(point, 1);
    nl = size(line, 1);
    if np ~= nl
        error('matGeom:linePosition', ...
            'Using diag option, number of points and lines should be the same');
    end
    
    % direction vector of the lines
    vx = line(:, 3);
    vy = line(:, 4);
    
    % difference of coordinates between point and line origins
    dx = point(:, 1) - line(:, 1);
    dy = point(:, 2) - line(:, 2);
    
else
    % General case -> return NP-by-NL array
    
    % direction vector of the lines
    vx = line(:, 3)';
    vy = line(:, 4)';
    
    % difference of coordinates between point and line origins
    dx = bsxfun(@minus, point(:, 1), line(:, 1)');
    dy = bsxfun(@minus, point(:, 2), line(:, 2)');

end

% squared norm of direction vector, with a check of validity 
delta = vx .* vx + vy .* vy;
invalidLine = delta < eps;
delta(invalidLine) = 1; 

% compute position of points projected on the line, by using normalised dot
% product (NP-by-NE array) 
pos = bsxfun(@rdivide, bsxfun(@times, dx, vx) + bsxfun(@times, dy, vy), delta);

% ensure degenerated edges are correclty processed (consider the first
% vertex is the closest)
pos(:, invalidLine) = 0;
