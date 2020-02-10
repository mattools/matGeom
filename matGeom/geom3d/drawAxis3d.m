function varargout=drawAxis3d(varargin)
%DRAWAXIS3D Draw a coordinate system and an origin.
%
%   drawAxis3d
%	Adds 3 cylinders to the current axis, corresponding to the directions
%	of the 3 basis vectors Ox, Oy and Oz.
%	Ox vector is red, Oy vector is green, and Oz vector is blue.
%
%   drawAxis3d(L, R)
%   Specifies the length L and the radius of the cylinders representing the
%   different axes.
%
%   Example
%   drawAxis3d
%
%   figure;
%   drawAxis3d(20, 1);
%   view(3); lighting('phong'); camlight('head'); axis('equal')
%
%   See also
%   drawAxisCube
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2007-08-14,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% Check if axes handle is specified
hAx = gca;
if ~isempty(varargin)
    if isAxisHandle(varargin{1})
        hAx = varargin{1};
        varargin(1)=[];
    end
end

% geometrical data
origin = zeros(3,3);
vec = eye(3,3);
color = vec;

% default parameters
L = 1;
r = L/10;

% extract parameters from input
if ~isempty(varargin)
	L = varargin{1};
end
if length(varargin)>1
	r = varargin{2};
end

% draw 3 cylinders and a ball
hold on;
sh=drawArrow3d(hAx, origin, vec*L, color, 'arrowRadius', r/L);
sh(4)=drawSphere(hAx,[origin(1,:) 2*r], 'faceColor', 'black');
gh = hggroup(hAx);
set(sh,'Parent',gh)

if nargout > 0
    varargout = {gh};
end