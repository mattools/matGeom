function point = intersectLineEdge(line, edge)
%INTERSECTLINEEDGE Return intersection between a line and an edge
%
%   P = intersectLineEdge(LINE, EDGE);
%   returns the intersection point of lines LINE and edge EDGE. 
%   LINE is a 1x4 array containing parametric representation of the line
%   (in the form [x0 y0 dx dy], see 'createLine' for details). 
%   EDGE is a 1x4 array containing coordinates of first and second point
%   (in the form [x1 y1 x2 y2], see 'createEdge' for details). 
%   
%   In case of colinear line and edge, returns [Inf Inf].
%   If line does not intersect edge, returns [NaN NaN].
%
%   If each input is [N*4] array, the result is a [N*2] array containing
%   intersections for each couple of edge and line.
%   If one of the input has N rows and the other 1 row, the result is a
%   [N*2] array.
%
%   See also:
%   lines2d, edges2d, intersectEdges, intersectLines
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   19/02/2004: add support for multiple lines.
%   08/03/2007: update doc

x0 =  line(:,1);
y0 =  line(:,2);
dx1 = line(:,3);
dy1 = line(:,4);
x1 =  edge(:,1);
y1 =  edge(:,2);
x2 = edge(:,3);
y2 = edge(:,4);
dx2 = x2-x1;
dy2 = y2-y1;

N1 = length(x0);
N2 = length(x1);

% indices of parallel lines
par = abs(dx1.*dy2-dx2.*dy1)<1e-14;

% indices of colinear lines
col = abs((x1-x0).*dy1-(y1-y0).*dx1)<1e-14 & par ;

xi(col) = Inf;
yi(col) = Inf;
xi(par & ~col) = NaN;
yi(par & ~col) = NaN;

i = ~par;

% compute intersection points
if N1==N2
	xi(i) = ((y1(i)-y0(i)).*dx1(i).*dx2(i) + x0(i).*dy1(i).*dx2(i) - x1(i).*dy2(i).*dx1(i)) ./ ...
        (dx2(i).*dy1(i)-dx1(i).*dy2(i)) ;
	yi(i) = ((x1(i)-x0(i)).*dy1(i).*dy2(i) + y0(i).*dx1(i).*dy2(i) - y1(i).*dx2(i).*dy1(i)) ./ ...
        (dx1(i).*dy2(i)-dx2(i).*dy1(i)) ;
elseif N1==1
	xi(i) = ((y1(i)-y0).*dx1.*dx2(i) + x0.*dy1.*dx2(i) - x1(i).*dy2(i).*dx1) ./ ...
        (dx2(i).*dy1-dx1.*dy2(i)) ;
	yi(i) = ((x1(i)-x0).*dy1.*dy2(i) + y0.*dx1.*dy2(i) - y1(i).*dx2(i).*dy1) ./ ...
        (dx1.*dy2(i)-dx2(i).*dy1) ;
elseif N2==1
	xi(i) = ((y1-y0(i)).*dx1(i).*dx2 + x0(i).*dy1(i).*dx2 - x1(i).*dy2.*dx1(i)) ./ ...
        (dx2.*dy1(i)-dx1(i).*dy2) ;
	yi(i) = ((x1-x0(i)).*dy1(i).*dy2 + y0(i).*dx1(i).*dy2 - y1(i).*dx2.*dy1(i)) ./ ...
        (dx1(i).*dy2-dx2.*dy1(i)) ;
end

point   = [xi' yi'];
out     = find(~isPointOnEdge(point, edge));
point(out, :) = repmat([NaN NaN], [length(out) 1]);
