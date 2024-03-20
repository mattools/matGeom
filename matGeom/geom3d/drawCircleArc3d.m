function varargout = drawCircleArc3d(varargin)
%DRAWCIRCLEARC3D Draw a 3D circle arc.
%
%   drawCircleArc3d([XC YC ZC R THETA PHI PSI START EXTENT])
%   [XC YC ZC]  : coordinate of arc center
%   R           : arc radius
%   [THETA PHI] : orientation of arc normal, in degrees (theta: 0->180).
%   PSI         : roll of arc (rotation of circle origin)
%   START       : starting angle of arc, from arc origin, in degrees
%   EXTENT      : extent of circle arc, in degrees (can be negative)
%   
%   Drawing options can be specified, as for the plot command.
%
%   See also 
%     angles3d, circles3d, drawCircle3d, drawCircleArc
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2005-02-21
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

% extract handle of axis to draw on
[hAx, varargin] = parseAxisHandle(varargin{:});

arc = varargin{1};
varargin(1) = [];

if iscell(arc)
    % save hold state
    holdState = ishold(hAx);
    hold(hAx, 'on');
    h = [];
    for i = 1:length(arc)
        h = [h drawCircleArc3d(hAx, arc{i}, varargin{:})]; %#ok<AGROW>
    end
    % restore hold state
    if ~holdState
        hold(hAx, 'off');
    end
    if nargout > 0
        varargout = {h};
    end
    return;
end

if size(arc, 1) > 1
    % save hold state
    holdState = ishold(hAx);
    hold(hAx, 'on');
    h = [];
    for i = 1:size(arc, 1)
        h = [h drawCircleArc3d(hAx, arc(i,:), varargin{:})]; %#ok<AGROW>
    end
    % restore hold state
    if ~holdState
        hold(hAx, 'off');
    end
    if nargout > 0
        varargout = {h};
    end
    return;
end

% get center and radius
xc  = arc(:,1);
yc  = arc(:,2);
zc  = arc(:,3);
r   = arc(:,4);

% get angle of normal
theta   = arc(:,5);
phi     = arc(:,6);
psi     = arc(:,7);

% get starting angle and angle extent of arc
start   = arc(:,8);
extent  = arc(:,9);

% positions on circle arc
N       = 60;
t       = linspace(start, start+extent, N+1) * pi / 180;

% compute coordinate of points
x       = r*cos(t)';
y       = r*sin(t)';
z       = zeros(length(t), 1);
curve   = [x y z];

% compute transformation from local basis to world basis
trans   = localToGlobal3d(xc, yc, zc, theta, phi, psi);

% transform circle arc
curve   = transformPoint3d(curve, trans);

% draw the curve with specified options
h = drawPolyline3d(hAx, curve, varargin{:});

if nargout > 0
    varargout = {h};
end

