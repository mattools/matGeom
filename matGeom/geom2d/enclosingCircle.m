function circle = enclosingCircle(pts)
%ENCLOSINGCIRCLE Find the minimum circle enclosing a set of points.
%
%   CIRCLE = enclosingCircle(POINTS);
%   compute cirlce CIRCLE=[xc yc r] which enclose all points POINTS given
%   as an [Nx2] array.
%
%
%   Rewritten from a file from
%           Yazan Ahed (yash78@gmail.com)
%
%   which was rewritten from a Java applet by Shripad Thite:
%   http://heyoka.cs.uiuc.edu/~thite/mincircle/
%
%   See also:
%   circles2d, points2d, boxes2d, triangleCircumCircle
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/07/2005.
%

% works on convex hull : it is faster
pts = pts(convhull(pts(:,1), pts(:,2)), :);

circle = recurseCircle(size(pts, 1), pts, 1, zeros(3, 2));



function circ = recurseCircle(n, p, m, b)
%    n: number of points given
%    m: an argument used by the function. Always use 1 for m.
%    bnry: an argument (3x2 array) used by the function to set the points that 
%          determines the circle boundry. You have to be careful when choosing this
%          array's values. I think the values should be somewhere outside your points
%          boundary. For my case, for example, I know the (x,y) I have will be something
%          in between (-5,-5) and (5,5), so I use bnry as:
%                       [-10 -10
%                        -10 -10
%                        -10 -10]


if m==4
    circ = createCircle(b(1,:), b(2,:), b(3,:));
    return;
end

circ = [Inf Inf 0];

if m == 2
    circ = [b(1,1:2) 0];
elseif m == 3
    c = (b(1,:) + b(2,:))/2;
    circ = [c distancePoints(b(1,:), c)];
end


for i = 1:n
    if distancePoints(p(i,:), circ(1:2)) > circ(3)
        if sum(b(:,1)==p(i,1) & b(:,2)==p(i,2)) == 0
            b(m,:) = p(i,:);
            circ = recurseCircle(i, p, m+1, b);
        end
    end
end

