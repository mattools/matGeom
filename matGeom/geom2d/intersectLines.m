function point = intersectLines(line1, line2, varargin)
%INTERSECTLINES Return all intersection points of N lines in 2D
%
%   PT = intersectLines(L1, L2);
%   returns the intersection point of lines L1 and L2. L1 and L2 are [1*4]
%   arrays, containing parametric representation of each line (in the form
%   [x0 y0 dx dy], see 'createLine' for details).
%   
%   In case of colinear lines, returns [Inf Inf].
%   In case of parallel but not colinear lines, returns [NaN NaN].
%
%   If each input is [N*4] array, the result is a [N*2] array containing
%   intersections of each couple of lines.
%   If one of the input has N rows and the other 1 row, the result is a
%   [N*2] array.
%
%   PT = intersectLines(L1, L2, EPS);
%   Specifies the tolerance for detecting parallel lines. Default is 1e-14.
%
%   Example
%   line1 = createLine([0 0], [10 10]);
%   line2 = createLine([0 10], [10 0]);
%   point = intersectLines(line1, line2)
%   point = 
%       5   5
%
%   See also
%   lines2d, edges2d, intersectEdges, intersectLineEdge
%   intersectLineCircle
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   19/02/2004 add support for multiple lines.
%   08/03/2007 update doc

x1 =  line1(:,1);
y1 =  line1(:,2);
dx1 = line1(:,3);
dy1 = line1(:,4);
x2 =  line2(:,1);
y2 =  line2(:,2);
dx2 = line2(:,3);
dy2 = line2(:,4);

N1 = length(x1);
N2 = length(x2);

% indices of parallel lines
par = abs(dx1.*dy2-dx2.*dy1) < 1e-14;

% indices of colinear lines
col = abs((x2-x1).*dy1-(y2-y1).*dx1) < 1e-14 & par ;

x0(col) = Inf;
y0(col) = Inf;
x0(par & ~col) = NaN;
y0(par & ~col) = NaN;

i = ~par;
% compute intersection points

if N1==N2
	x0(i) = ((y2(i)-y1(i)).*dx1(i).*dx2(i) + x1(i).*dy1(i).*dx2(i) - x2(i).*dy2(i).*dx1(i)) ./ ...
        (dx2(i).*dy1(i)-dx1(i).*dy2(i)) ;
	y0(i) = ((x2(i)-x1(i)).*dy1(i).*dy2(i) + y1(i).*dx1(i).*dy2(i) - y2(i).*dx2(i).*dy1(i)) ./ ...
        (dx1(i).*dy2(i)-dx2(i).*dy1(i)) ;
elseif N1==1
	x0(i) = ((y2(i)-y1).*dx1.*dx2(i) + x1.*dy1.*dx2(i) - x2(i).*dy2(i).*dx1) ./ ...
        (dx2(i).*dy1-dx1.*dy2(i)) ;
	y0(i) = ((x2(i)-x1).*dy1.*dy2(i) + y1.*dx1.*dy2(i) - y2(i).*dx2(i).*dy1) ./ ...
        (dx1.*dy2(i)-dx2(i).*dy1) ;
elseif N2==1
   	x0(i) = ((y2-y1(i)).*dx1(i).*dx2 + x1(i).*dy1(i).*dx2 - x2.*dy2.*dx1(i)) ./ ...
        (dx2.*dy1(i)-dx1(i).*dy2) ;
	y0(i) = ((x2-x1(i)).*dy1(i).*dy2 + y1(i).*dx1(i).*dy2 - y2.*dx2.*dy1(i)) ./ ...
        (dx1(i).*dy2-dx2.*dy1(i)) ;
else
    % formattage a rajouter
   	x0(i) = ((y2(i)-y1(i)).*dx1(i).*dx2(i) + x1(i).*dy1(i).*dx2(i) - x2(i).*dy2(i).*dx1(i)) ./ ...
        (dx2(i).*dy1(i)-dx1(i).*dy2(i)) ;
	y0(i) = ((x2(i)-x1(i)).*dy1(i).*dy2(i) + y1(i).*dx1(i).*dy2(i) - y2(i).*dx2(i).*dy1(i)) ./ ...
        (dx1(i).*dy2(i)-dx2(i).*dy1(i)) ;
end

point = [x0' y0'];
