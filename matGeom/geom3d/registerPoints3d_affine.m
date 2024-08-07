function [trans, points] = registerPoints3d_affine(points, target, varargin)
%registerPoints3d_affine Fit 3D affine transform using iterative algorithm.
%
%   TRANS = registerPoints3d_affine(POINTS, TARGET)
%   Computes the affine transform that maps the shape defines by POINTS
%   onto the shape defined by the points TARGET. Both POINTS and TARGET are
%   N-by-3 array of point coordinates, not necessarily the same size.
%   The result TRANS is a 4-by-4 affine transform.
%
%   TRANS = registerPoints3d_affine(POINTS, TARGET, NITERS)
%   Specifies the number of iterations for the algorithm.
%
%   [TRANS, POINTS2] = registerPoints3d_affine(...)
%   Also returns the set of transformed points.
%
%   Example
%     % read 3D data points
%     [v, ~] = readMesh('bunny_F5k.ply');
%     % initialize an arbitrary affine transform
%     rot = eulerAnglesToRotation3d([5 4 3]);
%     tra = createTranslation3d([0.8 0.6 0.4]);
%     sca1 = createScaling3d([0.97 1.02 0.99]);
%     sca2 = createScaling3d([1.01 0.98 1.02]);
%     transfo0 = tra * sca2 * rot * sca1;
%     % compute transformed (target) points, adding some noise
%     v2 = transformPoint3d(v, transfo0) + randn(size(v)) * 0.1;
%     % try to retrieve the affine affine transform
%     transfo = registerPoints3d_affine(v, v2);
%     vt = transformPoint3d(v, transfo);
%     % show results
%     figure; hold on; axis equal; axis([-10 10 -6 8 -8 12]); view([20 20]);
%     drawPoint3d(v, 'k.'); drawPoint3d(v2, 'b.'); drawPoint3d(vt, 'm.');
%     legend({'Original', 'Target', 'Registered'}, 'Location', 'NorthEast');
%
%   See also 
%     transforms3d, registerPoints3d_icp, fitAffineTransform3d
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2015-02-24, using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015-2024 INRA - Cepia Software Platform

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
    trans_i = fitAffineTransform3d(corrPoints, points);
    % trans_i = fitAffineTransform3d(points, corrPoints);

    % apply transform, and update cumulated transform
    points = transformPoint3d(points, trans_i);
    trans = trans_i * trans;
end
