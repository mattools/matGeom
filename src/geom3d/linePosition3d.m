function d = linePosition3d(point, line)
%LINEPOSITION3D Return the position of a 3D point on a 3D line
%
%   L = linePosition3d(POINT, LINE)
%   compute position of point POINT on the line LINE, relative to origin
%   point and direction vector of the line.
%   LINE has the form [x0 y0 z0 dx dy dy],
%   POINT has the form [x y z], and is assumed to belong to line.
%   If POINT does not belong to LINE, the position of its orthogonal
%   projection is computed instead.
%
%   L = linePosition3d(POINT, LINES)
%   if LINES is an array of NL lines, return NL positions, corresponding to
%   each line.
%
%   L = linePosition3d(POINTS, LINE)
%   if POINTS is an array of NP points, return NP positions, corresponding
%   to each point.
%
%   See also:
%   lines3d, points3d, createLine3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005.
%

%   HISTORY
%   05/01/2007 update doc
%   28/10/2010 change to bsxfun calculation for arbitrary input sizes
%       (Thanks to Sven Holcombe)

% vector from line origin to point
dp = bsxfun(@minus, point, line(:,1:3));

% direction vector of the line
dl = line(:, 4:6);

% compute position using dot product normalized with norm of line vector.
d = bsxfun(@rdivide, sum(bsxfun(@times, dp, dl), 2), sum(dl.^2, 2));
