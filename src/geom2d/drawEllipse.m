function varargout = drawEllipse(varargin)
%DRAWELLIPSE draw an ellipse on the current axis
%
%   drawEllipse(XC, YC, A, B);
%   Draws ellipse with center (XC, YC), with main axis of half-length A,
%   and second axis of half-length B. 
%
%   drawEllipse(..., THETA);
%   Also specifies orientation of ellipse, given in radians. Origin of
%   orientation is (Ox) axis. 
%
%   drawEllipse(PARAM);
%   Puts all parameters into one single array.
%
%   H = drawEllipse(...);
%   Also returns handles to the created line objects.
%
%   -> Parameters can also be arrays. In this case, all arrays are suposed 
%   to have the same size.
%
%
%   [X Y] = drawEllipse(...) 
%   Returns only positions of points used to draw ellipse, but does not
%   draw the ellipse on the current axe. This allows to compute
%   intersections of ellipse, or to keep result for a later use. 
%   In this case, only one ellipse path is computed. If several parameters
%   are entered, only the first one will be returned.
%
%   See also:
%   circles2d, drawCircle, drawEllipseArc
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/12/2003.
%

%   HISTORY
%   08/01/2004 returns coord of points when 2 output args are asked
%   08/01/2004 fix bug in extraction of input parameters, theta was not
%       initialized in case of array of size 1*5
%   13/08/2005 uses radians instead of degrees
%   21/02/2008 add support for drawing styles, code cleanup

% extract dawing style strings
styles = {};
for i = 1:length(varargin)
    if(ischar(varargin{i}))
        styles = varargin(i:end);
        varargin(i:end) = [];
        break;
    end
end

% extract ellipse parameters
theta = 0;
if length(varargin)==1
    ellipse = varargin{1};
    x0 = ellipse(1);
    y0 = ellipse(2);
    a  = ellipse(3);
    b  = ellipse(4);
    if length(ellipse)>4
        theta = ellipse(5);
    end
elseif length(varargin)>=4
    x0 = varargin{1};
    y0 = varargin{2};
    a  = varargin{3};
    b  = varargin{4};
    if length(varargin)>4
        theta = varargin{5};
    else
        theta = zeros(size(x0));
    end
else
    error('drawEllipse: please specify center x, center y and radii a and b');
end

if nargout<2
    % compute position of points to draw each ellipse
    h = zeros(length(x0), 1);
    for i=1:length(x0)
        t = linspace(0, 2*pi, 121);
        cot = cos(theta(i));
        sit = sin(theta(i));
        xt = x0(i) + a(i)*cos(t)*cot - b(i)*sin(t)*sit;
        yt = y0(i) + a(i)*cos(t)*sit + b(i)*sin(t)*cot;

        h(i) = line(xt, yt, styles{:});
    end
    
    % return handles if needed
    if nargout>0
        varargout{1}=h;
    end
else
    % return two arrays : x and y coordinates of points

    % compute position of points used to draw first ellipse
    t = linspace(0, 2*pi, 121);
    cot = cos(theta(i));
    sit = sin(theta(i));
    xt = x0(i) + a(i)*cos(t)*cot - b(i)*sin(t)*sit;
    yt = y0(i) + a(i)*cos(t)*sit + b(i)*sin(t)*cot;
    
    varargout{1} = xt;
    varargout{2} = yt;
end