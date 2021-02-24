function pos = linePosition3d(point, line)
% Return the position of a 3D point projected on a 3D line.
%
%   T = linePosition3d(POINT, LINE)
%   Computes position of point POINT on the line LINE, relative to origin
%   point and direction vector of the line.
%   LINE has the form [x0 y0 z0 dx dy dy],
%   POINT has the form [x y z], and is assumed to belong to line.
%   The result T is the value such that POINT = LINE(1:3) + T * LINE(4:6).
%   If POINT does not belong to LINE, the position of its orthogonal
%   projection is computed instead. 
%
%   T = linePosition3d(POINT, LINES)
%   If LINES is an array of NL lines, return NL positions, corresponding to
%   each line.
%
%   T = linePosition3d(POINTS, LINE)
%   If POINTS is an array of NP points, return NP positions, corresponding
%   to each point.
%
%   See also:
%   lines3d, createLine3d, distancePointLine3d, projPointOnLine3d
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

% size of input arguments
np = size(point, 1);
nl = size(line, 1);

if np == 1 || nl == 1 || np == nl
    % standard case where result is either scalar or vector
    
    % vector from line origin to point
    dp = bsxfun(@minus, point, line(:,1:3));
    
    % direction vector of the line
    vl = line(:, 4:6);
    
    % precompute and check validity of denominator
    denom = sum(vl.^2, 2);
    invalidLine = denom < eps;
    denom(invalidLine) = 1;
    
    % compute position using dot product normalized with norm of line vector.
    pos = bsxfun(@rdivide, sum(bsxfun(@times, dp, vl), 2), denom);
    
    % position on a degenerated line is set to 0
    pos(invalidLine) = 0;

else
    % reshape input 
    point = reshape(point, [np 1 3]);
    line = reshape(line, [1 nl 6]);
    
    % vector from line origin to point
    dp = bsxfun(@minus, point, line(:,:,1:3));
    
    % direction vector of the line
    vl = line(:, :, 4:6);
    
    % precompute and check validity of denominator
    denom = sum(vl.^2, 3);
    invalidLine = denom < eps;
    denom(invalidLine) = 1;
    
    % compute position using dot product normalized with norm of line vector.
    pos = bsxfun(@rdivide, sum(bsxfun(@times, dp, vl), 3), denom);
    
    % position on a degenerated line is set to 0
    pos(invalidLine) = 0;
end
