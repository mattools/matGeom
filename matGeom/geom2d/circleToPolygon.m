function varargout = circleToPolygon(circle, varargin)
%CIRCLETOPOLYGON Convert a circle into a series of points.
%
%   PTS = circleToPolygon(CIRC, N);
%   Converts the circle CIRC into a N-by-2 numeric array, containing the x
%   and y positions of vertices.
%   CIRC is given as [x0 y0 r], where x0 and y0 are coordinate of center,
%   and r is the radius.
%
%   If CIRC is a N-by-4 array, the fourth value is used as the angle (with
%   respect to the x axis) of the first vertex, in radians. Default value
%   is 0, corresponding to initial vertex with right-most position.
% 
%
%   P = circleToPolygon(CIRC);
%   uses a default value of N=64 vertices.
%
%   Example
%     % simple example
%     poly = circleToPolygon([30 20 15], 16);
%     figure; hold on;
%     axis equal;axis([0 50 0 50]);
%     drawPolygon(poly, 'b');
%     drawPoint(poly, 'bo');
%
%     % add a rotation angle to the first vertex position
%     figure; hold on; axis equal; axis([-12 12 -12 12]);
%     poly = circleToPolygon([0 0 10 pi/4], 10);
%     drawPolygon(poly, 'b'); drawVertices(poly);
%
%   See also 
%     circles2d, polygons2d, circleArcToPolyline, ellipseToPolygon
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2005-04-06
% Copyright 2005-2023 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% check input size
if size(circle, 1) > 1
    error('require circle to be 1-by-3 numeric array');
end

% determines number of points
N = 64;
if ~isempty(varargin)
    N = varargin{1};
end

% angular shift for initial vertex
t0 = 0;
if size(circle, 2) > 3
    t0 = circle(1, 4);
end

% create circle
t = linspace(0, 2*pi, N+1)' + t0;
t(end) = [];

% coordinates of circle points
x = circle(1) + circle(3) * cos(t);
y = circle(2) + circle(3) * sin(t);

% format output
if nargout == 1
    varargout{1} = [x y];
elseif nargout == 2
    varargout{1} = x;
    varargout{2} = y;    
end
