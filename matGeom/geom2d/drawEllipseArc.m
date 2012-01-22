function varargout = drawEllipseArc(varargin)
%DRAWELLIPSEARC Draw an ellipse arc on the current axis
%
%   drawEllipseArc(ARC) 
%   draw ellipse arc specified by ARC. ARC has the format:
%     ARC = [XC YC A B THETA T1 T2]
%   or:
%     ARC = [XC YC A B T1 T2] (isothetic ellipse)
%   with center (XC, YC), main axis of half-length A, second axis of
%   half-length B, and ellipse arc running from t1 to t2 (both in degrees,
%   in Counter-Clockwise orientation).
%
%   Parameters can also be arrays. In this case, all arrays are suposed to
%   have the same size...
%
%   drawEllipseArc(..., NAME, VALUE)
%   Specifies one or more parameters name-value pairs, as in the plot
%   function.
%
%   drawEllipseArc(AX, ...)
%   Sepcifies the handle of theaxis to draw on.
%
%   H = drawEllipseArc(...)
%   Returns handle(s) of the created graphic objects.
%
%   Example
%     % draw an ellipse arc: center = [10 20], radii = 50 and 30, theta = 45
%     arc = [10 20 50 30 45 -90 270];
%     figure;
%     axis([-50 100 -50 100]); axis equal;
%     hold on
%     drawEllipseArc(arc, 'color', 'r')
%
%     % draw another ellipse arc, between angles -60 and 70
%     arc = [10 20 50 30 45 -60 (60+70)];
%     figure;
%     axis([-50 100 -50 100]); axis equal;
%     hold on
%     drawEllipseArc(arc, 'LineWidth', 2);
%     ray1 = createRay([10 20], deg2rad(-60+45));
%     drawRay(ray1)
%     ray2 = createRay([10 20], deg2rad(70+45));
%     drawRay(ray2)
%
%   See also:
%   ellipses2d, drawEllipse, drawCircleArc
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 12/12/2003.
%


%   HISTORY
%   2008/10/10 uses fixed number of points for arc.
%   2011-03-30 use angles in degrees
%   2011-10-11 add management of axes handle

%% Extract input arguments

% extract handle of axis to draw on
if isscalar(varargin{1}) && ishandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% extract dawing style strings
styles = {};
for i = 1:length(varargin)
    if ischar(varargin{i})
        styles = varargin(i:end);
        varargin(i:end) = [];
        break;
    end
end

if length(varargin)==1
    ellipse = varargin{1};
    x0 = ellipse(1);
    y0 = ellipse(2);
    a  = ellipse(3);
    b  = ellipse(4);
    if size(ellipse, 2)>6
        theta   = ellipse(5);
        start   = ellipse(6);
        extent  = ellipse(7);
    else
        theta   = zeros(size(x0));
        start   = ellipse(5);
        extent  = ellipse(6);
    end
    
elseif length(varargin)>=6
    x0 = varargin{1};
    y0 = varargin{2};
    a  = varargin{3};
    b  = varargin{4};
    if length(varargin)>6
        theta   = varargin{5};
        start   = varargin{6};
        extent  = varargin{7};
    else
        theta   = zeros(size(x0));
        start   = varargin{5};
        extent  = varargin{6};
    end
    
else
    error('drawEllipseArc: please specify center x, center y and radii a and b');
end


%% Drawing

% allocate memory for handles
h = zeros(size(x0));

for i = 1:length(x0)
    % start and end angles
    t1 = deg2rad(start);
    t2 = t1 + deg2rad(extent);
    
    % vertices of ellipse
    t = linspace(t1, t2, 60);
    
    % convert angles to ellipse parametrisation
    sup = cos(t) > 0;
    t(sup)  = atan(a(i) / b(i) * tan(t(sup)));
    t(~sup) = atan2(a(i) / b(i) * tan(2*pi - t(~sup)), -1);
    t = mod(t, 2*pi);
    
    % precompute cos and sin of theta (given in degrees)
    cot = cosd(theta(i));
    sit = sind(theta(i));

    % compute position of points
    xt = x0(i) + a(i)*cos(t)*cot - b(i)*sin(t)*sit;
    yt = y0(i) + a(i)*cos(t)*sit + b(i)*sin(t)*cot;
    
    h(i) = plot(ax, xt, yt, styles{:});
end


%% Process output arguments

if nargout > 0
    varargout = {h};
end
