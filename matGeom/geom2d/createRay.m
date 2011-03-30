function ray = createRay(varargin)
%CREATERAY Create a ray (half-line), from various inputs
%
%   RAY = createRay(POINT, ANGLE)
%   POINT is a N*2 array giving starting point of the ray, and ANGLE is the
%   orientation of the ray.
%
%   RAY = createRay(X0, Y0, ANGLE)
%   Specify ray origin with 2 input arguments.
%
%   RAY = createRay(P1, P2)
%   Create a ray starting from point P1 and going in the direction of point
%   P2.
%
%   Ray is represented in a parametric form: [x0 y0 dx dy]
%   x = x0 + t*dx
%   y = y0 + t*dy;
%   for all t>0
%
%   Example
%   origin  = [3 4];
%   theta   = pi/6;
%   ray = createRay(origin, theta);
%   figure(1); clf; hold on;
%   axis([0 10 0 10]);
%   drawRay(ray);
%
%   See also:
%   rays2d, createLine, points2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-10-18
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

if length(varargin)==2
    p0 = varargin{1};
    arg = varargin{2};
    if size(arg, 2)==1
        % second input is the ray angle
        ray = [p0 cos(arg) sin(arg)];
    else
        % second input is another point
        ray = [p0 arg-p0];
    end
    
elseif length(varargin)==3   
    x = varargin{1};
    y = varargin{2};
    theta = varargin{3};
    ray = [x y cos(theta) sin(theta)];   

else
    error('Wrong number of arguments in ''createRay'' ');
end
