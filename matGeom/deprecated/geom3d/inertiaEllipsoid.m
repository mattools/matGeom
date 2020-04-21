function ell = inertiaEllipsoid(points)
%INERTIAELLIPSOID Inertia ellipsoid of a set of 3D points.
%
%   Note: Deprecated! Use equivalentEllipsoid instead.
%
%
%   ELL = inertiaEllipsoid(PTS)
%   Compute the inertia ellipsoid of the set of points PTS. The result is
%   an ellipsoid defined by:
%   ELL = [XC YC ZC A B C PHI THETA PSI]
%   where [XC YC ZY] is the center, [A B C] are lengths of semi-axes (in
%   decreasing order), and [PHI THETA PSI] are euler angles representing 
%   the ellipsoid orientation, in degrees.
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
%
%   See also
%     equivalentEllipsoid
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-03-12,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% deprecation warning
warning('geom3d:deprecated', ...
    [mfilename ' is deprecated, use ''equivalentEllipsoid'' instead']);

% number of points
n = size(points, 1);

% compute centroid
center = mean(points);

% compute the covariance matrix
covPts = cov(points)/n;

% perform a principal component analysis with 2 variables, 
% to extract inertia axes
[U, S] = svd(covPts);

% extract length of each semi axis
radii = sqrt(5) * sqrt(diag(S)*n)';

% sort axes from greater to lower
[radii, ind] = sort(radii, 'descend');

% format U to ensure first axis points to positive x direction
U = U(ind, :);
if U(1,1) < 0
    U = -U;
    % keep matrix determinant positive
    U(:,3) = -U(:,3);
end

% convert axes rotation matrix to Euler angles
angles = rotation3dToEulerAngles(U);

% concatenate result to form an ellipsoid object
ell = [center, radii, angles];
