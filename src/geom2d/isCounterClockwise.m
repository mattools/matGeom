function res = isCounterClockwise(p0, p1, p2, varargin)
%ISCOUNTERCLOCKWISE Compute relative orientation of 3 points
%
%   CCW = isCCW(P0, P1, P2);
%   Computes the orientation of the 3 points. The returns is:
%   +1 is the path P0->P1->P2 turns Counter-Clockwise,
%   -1 if the path turns Clockwise,
%   0 if the point P2 is located on the line segment [P0 P1].
%
%   CCW = isCCW(P0, P1, P2, EPS);
%   Specifies the threshold used for detecting colinearity of the 3 points.
%   Default value is 1e-12 (absolute).
%
%
%   Algorithm adapated from Sedgewick's book.
%

% get threshold value
eps = 1e-12;
if ~isempty(varargin)
    eps = varargin{1};
end

% extract vector coordinates
x0  = p0(:,1);
y0  = p0(:,2);
dx1 = p1(:,1)-x0;
dy1 = p1(:,2)-y0;
dx2 = p2(:,1)-x0;
dy2 = p2(:,2)-y0;

% init with 0
res = zeros(size(p0, 1), 1);

% check non colinear cases
res(dx1.*dy2 > dy1.*dx2) = 1;
res(dx1.*dy2 < dy1.*dx2) = -1;

% case of colinear points
ind = abs(dx1.*dy2 - dy1.*dx2)<eps;
res(ind(dx1(ind).*dx2(ind)<0 | dy1(ind).*dy2(ind)<0)) = -1;
res(ind(hypot(dx1(ind), dy1(ind)) < hypot(dx2(ind), dy2(ind)))) = 1;
