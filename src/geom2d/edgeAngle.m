function theta = edgeAngle(varargin)
%EDGEANGLE return angle of edge
%
%   A = edgeAngle(EDGE)
%   Returns the angle between horizontal, right-axis and the edge EDGE.
%   Angle is given in radians, between 0 and 2*pi, in counter-clockwise
%   direction. 
%   Notation for edge is [x1 y1 x2 y2] (coordinates of starting and ending
%   points).
%
%   See also:
%   edges2d, angles2d, edgeAngle, lineAngle, edgeLength
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2003.
%

edge = varargin{1};
line = createLine(edge(:,1:2), edge(:,3:4));
theta = lineAngle(line);
