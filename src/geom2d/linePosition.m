function d = linePosition(point, line)
%LINEPOSITION return position of a point on a line
%
%   L = linePosition(POINT, LINE);
%   Computes position of point POINT on the line LINE, relative to origin
%   point and direction vector of the line.
%   LINE has the form [x0 y0 dx dy],
%   POINT has the form [x y], and is assumed to belong to line.
%
%   L = linePosition(POINT, LINES);
%   If LINES is an array of NL lines, return NL positions, corresponding to
%   each line.
%
%   L = linePosition(POINTS, LINE);
%   If POINTS is an array of NP points, return NP positions, corresponding
%   to each point.
%
%   L = linePosition(POINTS, LINES);
%   If POINTS is an array of NP points and LINES is an array of NL lines,
%   return an array of [NP NL] position, corresponding to each couple
%   point-line.
%
%   See also:
%   lines2d, createLine, projPointOnLine, onLine
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 25/05/2004.
%

%   HISTORY :
%   07/07/2005 : manage multiple input


Nl = size(line, 1);
Np = size(point, 1);

if Np==Nl
    dxl = line(:, 3);
    dyl = line(:, 4);
    dxp = point(:, 1) - line(:, 1);
    dyp = point(:, 2) - line(:, 2);

    d = (dxp.*dxl + dyp.*dyl)./(dxl.*dxl+dyl.*dyl);

else
    % expand one of the array to have the same size
    dxl = repmat(line(:,3)', Np, 1);
    dyl = repmat(line(:,4)', Np, 1);
    dxp = repmat(point(:,1), 1, Nl) - repmat(line(:,1)', Np, 1);
    dyp = repmat(point(:,2), 1, Nl) - repmat(line(:,2)', Np, 1);

    d = (dxp.*dxl + dyp.*dyl)./(dxl.*dxl+dyl.*dyl);
end