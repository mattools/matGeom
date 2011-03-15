function varargout = circleAsPolygon(circle, varargin)
%CIRCLEASPOLYGON Convert a circle into a series of points
%
%   P = circleAsPolygon(CIRCLE, N);
%   convert circle given as [x0 y0 r], where x0 and y0 are coordinate of
%   center, and r is the radius, into an array of  [(N+1)x2] double, 
%   containing x and y values of points. 
%   The polygon is closed
%
%   P = circleAsPolygon(CIRCLE);
%   uses a default value of N=64 points
%
%   Example
%   circle = circleAsPolygon([10 0 5], 16);
%   figure;
%   drawPolygon(circle);
%
%   See also:
%   circles2d, polygons2d, createCircle
%
%
% ---------
% author : David Legland 
% created the 06/04/2005.
% Copyright 2010 INRA - Cepia Software Platform.
%

%   HISTORY
%   20/04/2007: return a closed polygon with N+1 vertices, use default N=64

% determines number of points
N = 64;
if ~isempty(varargin)
    N = varargin{1};
end

% create circle
t = linspace(0, 2*pi, N+1)';
x = circle(1) + circle(3)*cos(t);
y = circle(2) + circle(3)*sin(t);

if nargout==1
    varargout{1}=[x y];
elseif nargout==2
    varargout{1}=x;
    varargout{2}=y;    
end