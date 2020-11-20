function b = isPointInEllipsoid(point, elli, varargin)
% Check if a point is located inside a 3D ellipsoid.
%
%   output = isPointInEllipsoid(input)
%
%   Example
%     % create an ellipsoid
%     elli = [10 20 30   50 30 10   5 10 0];
%     display it
%     figure; hold on;
%     drawEllipsoid(elli, 'FaceColor', 'g', 'FaceAlpha', .5, ...
%         'drawEllipses', true, 'EllipseColor', 'b', 'EllipseWidth', 3);
%     view(3); axis equal;
%     % check for a point inside the ellipsoid
%     p1 = [20 30 35];
%     b1 = isPointInEllipsoid(p1, elli)
%     ans = 
%         1
%     % check for a point outside the ellipsoid
%     p2 = [-20 10 25];
%     b2 = isPointInEllipsoid(p2, elli)
%     ans = 
%         0
%   
%
%   See also
%     equivalentEllipsoid, drawEllipsoid, isPointInEllipse
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-11-19,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE.

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% compute ellipse to unit circle transform
rot = eulerAnglesToRotation3d(elli(7:9));
sca = createScaling3d(elli(4:6));
trans = inv(rot * sca);

% transform points to unit sphere basis
pTrans = bsxfun(@minus, point, elli(1:3));
pTrans = transformPoint3d(pTrans, trans);

% test if norm is smaller than 1
b = sqrt(sum(power(pTrans, 2), 2)) - 1 <= tol;
    