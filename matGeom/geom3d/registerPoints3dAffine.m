function [trans, points] = registerPoints3dAffine(points, target, varargin)
% Fit 3D affine transform using iterative algorithm.
%
%   TRANS = registerPoints3dAffine(POINTS, TARGET)
%   Computes the affine transform that maps the shape defines by POINTS
%   onto the shape defined by the points TARGET. Both POINTS and TARGET are
%   N-by-3 array of point coordinates, not necessarily the same size.
%   The result TRANS is a 4-by-4 affine transform.
%
%   TRANS = registerPoints3dAffine(POINTS, TARGET, NITER)
%   Specifies the number of iterations for the algorithm.
%
%   [TRANS, POINTS2] = registerPoints3dAffine(...)
%   Also returns the set of transformed points.
%
%   Example
%     registerPoints3dAffine
%
%   See also
%     transforms3d, fitAffineTransform3d
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2015-02-24,    using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015 INRA - Cepia Software Platform.


nIters = 10;
if ~isempty(varargin)
    nIters = varargin{1};
end

% keep original points to transform them at each
trans = [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];

for i = 1:nIters
    % identify target points for each source point
    inds = findClosestPoint(points, target);
    corrPoints = target(inds, :);
    
    % compute transform for current iteration
    trans_i = fitAffineTransform3d(points, corrPoints);

    % apply transform, and update cumulated transform
    points = transformPoint3d(points, trans_i);
    trans = trans_i * trans;
end
