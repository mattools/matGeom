function varargout = drawCircleArc3d(arc, varargin)
%DRAWCIRCLEARC3D Draw a 3D circle arc
%
%   drawCircleArc3d([XC YC ZC R THETA PHI PSI START EXTENT])
%   [XC YC ZC]  : coordinate of arc center
%   R           : arc radius
%   [THETA PHI] : orientation of arc normal (theta : 0->pi).
%   PSI         : roll of arc (rotation of circle origin)
%   START       : starting angle of arc, from arc origin
%   EXTENT      : extent of circle arc (can be negative)
%   
%   Drawing options can be specified, as for the plot command.
%
%   See also
%   angles3, circles3d, drawCircle3d, drawCircleArc
%
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005
%

%   HISTORY
%   2007-06-27 change 3D angle convention
%   2010-03-08 use drawPolyline3d


if iscell(arc)
    h = [];
    for i=1:length(arc)
        h = [h drawCircleArc3d(arc{i}, varargin{:})]; %#ok<AGROW>
    end
    if nargout>0
        varargout{1}=h;
    end
    return;
end

if size(arc, 1)>1
    h = [];
    for i=1:size(arc, 1)
        h = [h drawCircleArc3d(arc(i,:), varargin{:})]; %#ok<AGROW>
    end
    if nargout>0
        varargout{1}=h;
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
N       = 64;
t       = linspace(start, start+extent, N+1);

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
h = drawPolyline3d(curve, varargin{:});

if nargout > 0
    varargout{1} = h;
end

