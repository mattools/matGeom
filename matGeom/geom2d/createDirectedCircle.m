function circle = createDirectedCircle(varargin)
%CREATEDIRECTEDCIRCLE Create a directed circle
%
%   C = createDirectedCircle(P1, P2, P3);
%   Creates a circle going through the given points.
%   C is a 1*4 array of the form: [XC YC R INV].
%   The last parameter is set to 1 if the points are located in clockwise
%   order on the circle.
%
%   C = createDirectedCircle(P1, P2);
%   Creates the circle whith center P1 and passing throuh the point P2.
%
%   Works also when input are point arrays the same size, in this case the
%   result has as many lines as the point arrays.
%
%   See also:
%   circles2d, createCircle
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 12/01/2005.
%

if nargin == 2
    % inputs are the center and a point on the circle
    p1 = varargin{1};
    p2 = varargin{2};
    x0 = (p1(:,1) + p2(:,1))/2;
    y0 = (p1(:,2) + p2(:,2))/2;
    r = hypot((p2(:,1)-p1(:,1)), (p2(:,2)-p1(:,2)))/2;
    
    % circle is direct by default
    d = 0;
    
elseif nargin == 3
    % inputs are three points on the circle
    p1 = varargin{1};
    p2 = varargin{2};
    p3 = varargin{3};

    % compute circle center
    line1 = medianLine(p1, p2);
    line2 = medianLine(p1, p3);
    center = intersectLines(line1, line2);
    x0 = center(:, 1); 
    y0 = center(:, 2);
    
    % circle radius
    r = hypot((p1(:,1)-x0), (p1(:,2)-y0));
    
    % compute circle orientation
    angle = angle3Points(p1, center, p2) + angle3Points(p2, center, p3);
    d = angle>2*pi;
end
    
        
circle = [x0 y0 r d];