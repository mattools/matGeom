function ell = inertiaEllipsoid(points)
%INERTIAELLIPSOID Inertia ellipsoid of a set of 3D points
%
%   ELL = inertiaEllipsoid(PTS)
%   Compute the inertia ellipsoid of the set of points PTS. The result is
%   an ellispoid defined by:
%   ELL = [XC YC ZC A B C PHI THETA PSI]
%   where [XC YC ZY] is the centern [A B C] are length of semi-axes (in
%   decreasing order), and [PHI THETA PSI] are euler angles representing
%   the ellipsoid orientation, in degrees.
%
%   Example
%   inertiaEllipsoid
%
%   See also
%   spheres, drawEllipsoid, inertiaEllipse
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-03-12,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% number of points
n = size(points, 1);

% compute centroid
center = mean(points);

% compute the covariance matrix
covPts = cov(points)/n;

% perform a principal component analysis with 2 variables, 
% to extract inertia axes
[U S] = svd(covPts);

% extract length of each semi axis
radii = 2 * sqrt(diag(S)*n)';

% sort axes from greater to lower
[radii ind] = sort(radii, 'descend');

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
ell = [center radii angles];
