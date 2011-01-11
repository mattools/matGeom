function varargout = drawEllipseArc(varargin)
%DRAWELLIPSEARC Draw an ellipse arc on the current axis
%
%   drawEllipseArc(ARC) 
%   draw ellipse arc specified by ARC. ARC has the format:
%     ARC = [XC YC A B THETA T1 T2]
%   or:
%     ARC = [XC YC A B T1 T2] (isothetic ellipse)
%   with center (XC, YC), main axis of half-length A, second axis of
%   half-length B, and ellipse arc running from t1 to t2 (both in radians,
%   in Counter-Clockwise orientation).
%
%   Parameters can also be arrays. In this case, all arrays are suposed to
%   have the same size...
%
%
%   See also:
%   circles2d, drawEllipse, drawCircleArc
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 12/12/2003.
%


%   HISTORY
%   2008/10/10 uses fixed number of points for arc.

theta = 0;
if length(varargin)==1
    ellipse = varargin{1};
    x0 = ellipse(1);
    y0 = ellipse(2);
    a  = ellipse(3);
    b  = ellipse(4);
    if size(ellipse, 1)>6
        theta = ellipse(5)*pi/180;
        t1 = ellipse(6)*pi/180;
        t2 = ellipse(7)*pi/180;
    else
        t1 = ellipse(5)*pi/180;
        t2 = ellipse(6)*pi/180;
    end
elseif length(varargin)>=6
    x0 = varargin{1};
    y0 = varargin{2};
    a  = varargin{3};
    b  = varargin{4};
    if length(varargin)>6
        theta = varargin{5}*pi/180;
        t1 = varargin{6}*pi/180;
        t2 = varargin{7}*pi/180;
    else
        t1 = varargin{5}*pi/180;
        t2 = varargin{6}*pi/180;
    end
else
    error('drawellipse : please specify center x, center y and radii a and b');
end


h = zeros(size(x0));

for i=1:length(x0)
    t = linspace(t1, t2, 60);
    % use relation between parametric representation of ellipse, and angle :
    t = mod(atan(a(i)/b(i)*tan(t)).*(cos(t)>0) + atan2(a(i)/b(i)*tan(2*pi-t), -1).*(cos(t)<0), 2*pi);
    
    % compute position of points
    xt = x0(i) + a(i)*cos(t)*cos(theta(i)) - b(i)*sin(t)*sin(theta(i));
    yt = y0(i) + a(i)*cos(t)*sin(theta(i)) + b(i)*sin(t)*cos(theta(i));
    
    h(i) = line(xt, yt);
end

if nargout>0
    varargout{1}=h;
end