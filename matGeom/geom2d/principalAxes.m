function varargout = principalAxes(points)
%PRINCIPALAXES Principal axes of a set of ND points.
%
%   [CENTER, ROTMAT] = principalAxes(PTS)
%   [CENTER, ROTMAT, SCALES] = principalAxes(PTS)
%   Computes the principal axes of a set of points given in a N-by-ND array
%   and returns the result in two or three outputs:
%   CENTER  is the centroid of the points, as a 1-by-ND row vector
%   ROTMAT  represents the orientation of the point cloud, as a ND-by-ND
%           rotation matrix
%   SCALES  is the scaling factor along each dimension, as a 1-by-ND row
%           vector.
%
%   Example
%     pts = randn(100, 2);
%     pts = transformPoint(pts, createScaling(5, 2));
%     pts = transformPoint(pts, createRotation(pi/6));
%     pts = transformPoint(pts, createTranslation(3, 4));
%     [center, rotMat] = principalAxes(pts);
%
%   See also
%     equivalentEllipse, equivalentEllipsoid, principalAxesTransform
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2019-08-12,    using Matlab 9.6.0.1072779 (R2019a)
% Copyright 2019 INRAE - Cepia Software Platform.

% number and dimension of points
n = size(points, 1);
nd = size(points, 2);

% compute centroid
center = mean(points);

% compute the covariance matrix
covPts = cov(points) / n;

% perform a principal component analysis to extract principal axes
[rotMat, S] = svd(covPts);

% extract length of each semi axis
radii = sqrt(diag(S) * n);

% sort axes from greater to lower
[radii, ind] = sort(radii, 'descend');
radii = radii';

% format U to ensure first axis points to positive x direction
rotMat = rotMat(ind, :);
if rotMat(1,1) < 0 && nd > 2
    rotMat = -rotMat;
    % keep matrix determinant positive
    rotMat(:,3) = -rotMat(:,3);
end

% format output
if nargout == 2
    varargout = {center, rotMat};
elseif nargout == 3
    varargout = {center, rotMat, radii};
end