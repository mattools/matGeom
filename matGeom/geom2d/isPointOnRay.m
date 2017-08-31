function b = isPointOnRay(point, ray, varargin)
%ISPOINTONRAY Test if a point belongs to a ray
%
%   B = isPointOnRay(PT, RAY);
%   Returns 1 if point PT belongs to the ray RAY.
%   PT is given by [x y] and RAY by [x0 y0 dx dy].
%
%   If PT is a N-by-2 array, and RAY is a M-by-4 array, then the result is
%   a N-by-M array containing the result of each pair-wise test.
%
%   B = isPointOnRay(PT, RAY, TOL);
%   Specifies the tolerance to use for testing if point is on the ray.
%
%   Example
%     ray = [10 20 3 4];
%     % test for a point on the ray
%     p1 = [16 28]; 
%     isPointOnRay(p1, ray)
%     ans =
%       logical
%        0
%     % test for a point on the supporting line but "before" the origin
%     p2 = [7 16];
%     isPointOnRay(p1, ray)
%     ans =
%       logical
%        0
% 
%   See also:
%   rays2d, points2d, isPointOnLine, isPointOnEdge
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   07/07/2005 normalize condition to test if on the line and add support
%       of multiple rays or points
%   22/05/2009 rename to isPointOnRay, add psb to specify tolerance
%   26/01/2010 was drawing a line before making test

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% number of rays and points
Nr = size(ray, 1);
Np = size(point, 1);

% if several rays or several points, adapt sizes of arrays
x0 = repmat(ray(:,1)', Np, 1);
y0 = repmat(ray(:,2)', Np, 1);
dx = repmat(ray(:,3)', Np, 1);
dy = repmat(ray(:,4)', Np, 1);
xp = repmat(point(:,1), 1, Nr);
yp = repmat(point(:,2), 1, Nr);

% test if points belongs to the supporting line
b1 = abs((xp-x0).*dy - (yp-y0).*dx) ./ (dx.*dx + dy.*dy) < tol;

% check if points lie the good direction on the rays
ind     = abs(dx) > abs(dy);
t       = zeros(size(b1));
t(ind)  = (xp(ind) - x0(ind)) ./ dx(ind);
t(~ind) = (yp(~ind) - y0(~ind)) ./ dy(~ind);

% combine the two tests
b = b1 & (t >= 0);
