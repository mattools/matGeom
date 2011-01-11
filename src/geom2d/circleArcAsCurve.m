function varargout = circleArcAsCurve(arc, N)
%CIRCLEARCASCURVE convert a circle arc into a series of points
%
%   P = circleArcAsCurve(ARC, N);
%   convert the circle ARC into a series of N points. ARC is given in the
%   form [XC YC R THETA1 THETA2], where XC and YC define the center of the
%   circle, R its radius, and THETA1 and THETA2 the start and end angle
%   respectively, in radians.
%   The result is given in an array of [Nx2] values representing
%   coordinates of the N points.
%
%   See also:
%   circles2d, circleAsPolygon, drawCircle, drawPolygon
%
%
% ---------
% author : David Legland 
% created the 22/05/2006.
% Copyright 2010 INRA - Cepia Software Platform.
%

%   HISTORY


if arc(5)>arc(4)
    t = linspace(arc(4), arc(5), N)';
else
    t = linspace(arc(5), arc(4)+2*pi, N)';
end

x = arc(1) + arc(3)*cos(t);
y = arc(2) + arc(3)*sin(t);

if nargout==1
    varargout{1}=[x y];
elseif nargout==2
    varargout{1}=x;
    varargout{2}=y;    
end