function [trans, points] = registerICP(points, target, varargin)
%REGISTERICP Fit affine transform by Iterative Closest Point algorithm
%
%   TRANS = registerICP(POINTS, TARGET)
%   Computes the affine transform that maps the shape defines by POINTS
%   onto the shape defined by the points TARGET. Both POINTS and TARGET are
%   N-by-2 array of point coordinates, not necessarily the same size.
%   The result TRANS is a 3-by-3 affine transform.
%
%   TRANS = registerICP(POINTS, TARGET, NITER)
%   Specifies the number of iterations for the algorithm.
%
%   [TRANS, POINTS2] = registerICP(...)
%   Also returns the set of transformed points.
%
%   Example
%   registerICP
%
%   See also
%     tansforms2d, fitAffineTransform2d
%
 
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2015-02-24,    using Matlab 8.4.0.150421 (R2014b)
% Copyright 2015 INRA - Cepia Software Platform.


nIter = 10;
if ~isempty(varargin)
    nIter = varargin{1};
end

% keep original points to transform them at each
trans = [1 0 0;0 1 0;0 0 1];

for i = 1:nIter
    % identify target points for each source point
    inds = findClosestPoint(points, target);
    corrPoints = target(inds, :);
    
    % compute transform for current iteration
    trans_i = fitAffineTransform2d(points, corrPoints);

    % apply transform, and update cumulated transform
    points = transformPoint(points, trans_i);
    trans = trans_i * trans;
end
