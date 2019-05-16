function plane = fitPlane(points)
%FITPLANE  Fit a 3D plane to a set of points.
%
%   PLANE = fitPlane(POINTS)
%
%   Example
%     pts = randn(300, 3);
%     pts = transformPoint3d(pts, createScaling3d([6 4 2]));
%     pts = transformPoint3d(pts, createRotationOx(pi/6));
%     pts = transformPoint3d(pts, createRotationOy(pi/4));
%     pts = transformPoint3d(pts, createRotationOz(pi/3));
%     pts = transformPoint3d(pts, createTranslation3d([5 4 3]));
%     elli = inertiaEllipsoid(pts);
%     figure; drawPoint3d(pts); axis equal;
%     hold on; drawEllipsoid(elli, ...
%         'drawEllipses', true, 'EllipseColor', 'b', 'EllipseWidth', 3);
%     plane = fitPlane(pts);
%     drawPlane3d(plane, 'm');
%
%   See also
%     planes3d, inertiaEllipsoid, fitLine3d
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-11-11,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% number of points
n = size(points, 1);

% compute centroid
center = mean(points);

% compute the covariance matrix
covPts = cov(points)/n;

% perform a principal component analysis with 2 variables, 
% to extract inertia axes
[U, S] = svd(covPts);

% sort axes from greater to lower
[dummy, ind] = sort(diag(S), 'descend'); %#ok<ASGLU>

% format U to ensure first axis points to positive x direction
U = U(ind, :);
if U(1,1) < 0
    U = -U;
    % keep matrix determinant positive
    U(:,3) = -U(:,3);
end

plane = [center U(:,1)' U(:,2)'];
