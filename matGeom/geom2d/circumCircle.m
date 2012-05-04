function varargout = circumCircle(varargin)
%CIRCUMCIRCLE Circumscribed circle of three points
%
%   CIRC = circumCircle(TRI)
%   CIRC = circumCircle(P1, P2, P3)
%   Compute circumcircle of a triangle given by 3 points.
%
%   Example
%     T = [10 20; 70 20; 30 70];
%     C = circumCircle(T);
%     figure; drawPolygon(T, 'linewidth', 2);
%     hold on; drawCircle(C);
%     axis equal; axis([0 100 0 100]);
%
%   See also
%     circles2d, enclosingCircle, circumCenter
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% extract the three points
[a b c] = parseThreePoints(varargin{:});

% circle center
center = circumCenter(a, b, c);

% radius
r = distancePoints(center, a);

% format output
varargout = {[center r]};
