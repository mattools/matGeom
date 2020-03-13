function varargout = principalAxesTransform(pts)
% Align a set of points along its principal axes.
%
%   TRANSFO = principalAxesTransform(PTS)
%   Computes the affine transform that will transform the input array PTS
%   such that its principal axes become aligned with main axes.
%
%   [TRANSFO, PTS2] = principalAxesTransform(PTS)
%   Also returns the result of the transform applied to the points.
%
%   Example
%   principalAxesTransform
%
%   See also
%     principalAxes, equivalentEllipse, equivalentEllipsoid
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2020-03-06,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2020 INRAE - Cepia Software Platform.

% computes principal axes
[center, rotMat] = principalAxes(pts);

% concatenate into affine matrix
nd = size(pts, 2);
transfo = inv([rotMat center'; zeros(1, nd) 1]);


% format output
if nargout < 2
    varargout = transfo;
else
    if nd == 2
        pts2 = transformPoint(pts, transfo);
    else
        pts2 = transformPoint3d(pts, transfo);
    end
    varargout = {transfo, pts2};
end
