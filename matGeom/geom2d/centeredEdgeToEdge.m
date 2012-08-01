function edge = centeredEdgeToEdge(cedge)
%CENTEREDEDGETOEDGE Convert a centered edge to a two-points edge
%
%   EDGE = centeredEdgeToEdge(CEDGE)
%   Converts an edge represented using center, length and orientation to an
%   edge represented using coordinates of end points.
%
%   Example
%     % example of conversion on a 'pythagorean' edge
%     cedge = [30 40 50 atand(3/4)];
%     centeredEdgeToEdge(cedge)
%     ans =
%         10    25    50    55
%
%
%   See also
%     edges2d, drawCenteredEdge, drawOrientedBox
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-07-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% length and orientation
len = cedge(:,3);
ori = cedge(:,4);

% x and y shifts around center
dx = len * cosd(ori) / 2;
dy = len * sind(ori) / 2;

% coordinates of extremities
edge = [cedge(:,1:2)-[dx dy] cedge(:,1:2)+[dx dy]];
