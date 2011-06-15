function d = linePosition(point, line)
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

% number of inputs
Nl = size(line, 1);
Np = size(point, 1);

if Np == Nl
    % if both inputs have the same size, no problem
    dxl = line(:, 3);
    dyl = line(:, 4);
    dxp = point(:, 1) - line(:, 1);
    dyp = point(:, 2) - line(:, 2);

elseif Np == 1
    % one point, several lines
    dxl = line(:, 3);
    dyl = line(:, 4);
    dxp = point(ones(Nl, 1), 1) - line(:, 1);
    dyp = point(ones(Nl, 1), 2) - line(:, 2);
    
elseif Nl == 1
    % one line, several points
    dxl = line(ones(Np, 1), 3);
    dyl = line(ones(Np, 1), 4);
    dxp = point(:, 1) - line(1);
    dyp = point(:, 2) - line(2);
    
else
    % expand one of the array to have the same size
    dxl = repmat(line(:,3)', Np, 1);
    dyl = repmat(line(:,4)', Np, 1);
    dxp = repmat(point(:,1), 1, Nl) - repmat(line(:,1)', Np, 1);
    dyp = repmat(point(:,2), 1, Nl) - repmat(line(:,2)', Np, 1);
end

% compute position
d = (dxp.*dxl + dyp.*dyl) ./ (dxl.^2 + dyl.^2);

