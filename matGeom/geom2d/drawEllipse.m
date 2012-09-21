function varargout = drawEllipse(varargin)
%DRAWELLIPSE Draw an ellipse on the current axis
%
%   drawEllipse(ELLI);
%   Draws the ellipse ELLI in the form [XC YC RA RB THETA], with center
%   (XC, YC), with main axis of half-length RA and RB, and orientation
%   THETA in degrees counted counter-clockwise.
%
%   drawEllipse(XC, YC, RA, RB);
%   drawEllipse(XC, YC, RA, RB, THETA);
%   Specifies ellipse parameters as separate arguments (old syntax).
%
%   drawEllipse(..., NAME, VALUE);
%   Specifies drawing style of ellipse, see the help of plot function.
%
%   H = drawEllipse(...);
%   Also returns handles to the created line objects.
%
%   -> Parameters can also be arrays. In this case, all arrays are supposed 
%   to have the same size.
%
%   Example:
%   % Draw an ellipse centered in [50 50], with semi major axis length of
%   % 40, semi minor axis length of 20, and rotated by 30 degrees.
%     figure(1); clf; hold on;
%     drawEllipse([50 50 40 20 30]);
%     axis equal;
%
%   % add another ellipse with different orientation and style
%     drawEllipse([50 50 40 20 -10], 'linewidth', 2, 'color', 'g');
%
%   See also:
%   ellipses2d, drawCircle, drawEllipseArc, ellipseToPolygon
%
%   ---------
%   author : David Legland 
%   e-mail: david.legland@grignon.inra.fr
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/12/2003.
%

%   HISTORY
%   2004-01-08 returns coord of points when 2 output args are asked
%   2004-01-08 fix bug in extraction of input parameters, theta was not
%       initialized in case of array of size 1*5
%   2005-08-13 uses radians instead of degrees
%   2008-02-21 add support for drawing styles, code cleanup
%   2011-03-30 use degrees instead of radians, remove [x y] = ... format
%   2011-10-11 add support for axis handle


%% Extract input arguments

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
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

% extract ellipse parameters
if length(varargin) == 1
    % ellipse is given in a single array
    ellipse = varargin{1};
    x0 = ellipse(:, 1);
    y0 = ellipse(:, 2);
    a  = ellipse(:, 3);
    b  = ellipse(:, 4);
    if length(ellipse) > 4
        theta = ellipse(:, 5);
    else
        theta = zeros(size(x0));
    end
    
elseif length(varargin) >= 4
    % ellipse parameters given as separate arrays
    x0 = varargin{1};
    y0 = varargin{2};
    a  = varargin{3};
    b  = varargin{4};
    if length(varargin) > 4
        theta = varargin{5};
    else
        theta = zeros(size(x0));
    end
    
else
    error('drawEllipse: incorrect input arguments');
end


%% Process drawing of a set of ellipses

% angular positions of vertices
t = linspace(0, 2*pi, 145);

% compute position of points to draw each ellipse
h = zeros(length(x0), 1);
for i = 1:length(x0)
    % pre-compute rotation angles (given in degrees)
    cot = cosd(theta(i));
    sit = sind(theta(i));
    
    % compute position of points used to draw current ellipse
    xt = x0(i) + a(i) * cos(t) * cot - b(i) * sin(t) * sit;
    yt = y0(i) + a(i) * cos(t) * sit + b(i) * sin(t) * cot;
    
    % stores handle to graphic object
    h(i) = plot(ax, xt, yt, styles{:});
end

% return handles if required
if nargout > 0
    varargout = {h};
end

