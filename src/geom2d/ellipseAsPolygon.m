function varargout = ellipseAsPolygon(ellipse, N)
%ELLIPSEASPOLYGON convert an ellipse into a series of points
%
%   P = ellipseAsPolygon(ELL, N);
%   converts ELL given as [x0 y0 a b] or [x0 y0 a b theta] into an array
%   of  [Nx2] double, containing x and y values of the N points. 
%
%   The polygon is not closed, the last point is not the same as  to the
%   first one.
%
%   See also:
%   circles2d, circleAsPolygon, rectAsPolygon, drawEllipse
%
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2005.
%

%   HISTORY

% angle of ellipse
theta = 0;
if size(ellipse, 2)>4
    theta = ellipse(:,5);
end

% get ellipse parameters
xc = ellipse(:,1);
yc = ellipse(:,2);
a = ellipse(:,3);
b = ellipse(:,4);

% create time basis
t = (0:2*pi/N:2*pi*(1-1/N))';

% position of points
x = xc + a*cos(t)*cos(theta) - b*sin(t)*sin(theta);
y = yc + a*cos(t)*sin(theta) + b*sin(t)*cos(theta);

% format output depending on number of a param.
if nargout==1
    varargout{1}=[x y];
elseif nargout==2
    varargout{1}=x;
    varargout{2}=y;    
end