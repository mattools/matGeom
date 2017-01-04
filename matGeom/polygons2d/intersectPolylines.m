function pts = intersectPolylines(poly1, varargin)
%INTERSECTPOLYLINES Find the common points between 2 polylines
%
%   INTERS = intersectPolylines(POLY1, POLY2)
%   Returns the intersection points between two polylines. Each polyline is
%   defined by a N-by-2 array representing coordinates of its vertices: 
%   [X1 Y1 ; X2 Y2 ; ... ; XN YN]
%   INTERS is a NP-by-2 array containing coordinates of intersection
%   points.
%
%   INTERS = intersectPolylines(POLY1)
%   Compute self-intersections of the polyline.
%
%   Example
%   % Compute intersection points between 2 simple polylines
%     poly1 = [20 10 ; 20 50 ; 60 50 ; 60 10];
%     poly2 = [10 40 ; 30 40 ; 30 60 ; 50 60 ; 50 40 ; 70 40];
%     pts = intersectPolylines(poly1, poly2);
%     figure; hold on; 
%     drawPolyline(poly1, 'b');
%     drawPolyline(poly2, 'm');
%     drawPoint(pts);
%     axis([0 80 0 80]);
%
%   This function is largely based on the 'interX' function, found on the
%   FileExchange:
%   https://fr.mathworks.com/matlabcentral/fileexchange/22441-curve-intersections
%   
%   See also
%   polygons2d, polylineSelfIntersections, intersectLinePolygon
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2009-06-15,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

% The code is a slight rewritting of the interX function, consisting in
% avoiding argument transposition in the begining of the function. Comment
% of original submission are kept here for information.
%
%INTERX Intersection of curves
%   P = INTERX(L1,L2) returns the intersection points of two curves L1 
%   and L2. The curves L1,L2 can be either closed or open and are described
%   by two-row-matrices, where each row contains its x- and y- coordinates.
%   The intersection of groups of curves (e.g. contour lines, multiply 
%   connected regions etc) can also be computed by separating them with a
%   column of NaNs as for example
%
%         L  = [x11 x12 x13 ... NaN x21 x22 x23 ...;
%               y11 y12 y13 ... NaN y21 y22 y23 ...]
%
%   P has the same structure as L1 and L2, and its rows correspond to the
%   x- and y- coordinates of the intersection points of L1 and L2. If no
%   intersections are found, the returned P is empty.
%
%   P = INTERX(L1) returns the self-intersection points of L1. To keep
%   the code simple, the points at which the curve is tangent to itself are
%   not included. P = INTERX(L1,L1) returns all the points of the curve 
%   together with any self-intersection points.
%   
%   Example:
%       t = linspace(0,2*pi);
%       r1 = sin(4*t)+2;  x1 = r1.*cos(t); y1 = r1.*sin(t);
%       r2 = sin(8*t)+2;  x2 = r2.*cos(t); y2 = r2.*sin(t);
%       P = InterX([x1;y1],[x2;y2]);
%       plot(x1,y1,x2,y2,P(1,:),P(2,:),'ro')
%
%   Author : NS
%   Version: 3.0, 21 Sept. 2010
%
%   Two words about the algorithm: Most of the code is self-explanatory.
%   The only trick lies in the calculation of C1 and C2. To be brief, this
%   is essentially the two-dimensional analog of the condition that needs
%   to be satisfied by a function F(x) that has a zero in the interval
%   [a,b], namely
%           F(a)*F(b) <= 0
%   C1 and C2 exactly do this for each segment of curves 1 and 2
%   respectively. If this condition is satisfied simultaneously for two
%   segments then we know that they will cross at some point. 
%   Each factor of the 'C' arrays is essentially a matrix containing 
%   the numerators of the signed distances between points of one curve
%   and line segments of the other.


% Check number of inputs
narginchk(1, 2);

% Specific init depending on number of inputs
if nargin == 1
    % Compute self-intersections 
    % -> Avoid the inclusion of common points
    poly2 = poly1;
    hF = @lt;
else
    % Compute intersections between distinct lines
    poly2 = varargin{1}; 
    hF = @le;
end

% Get coordinates of polyline vertices
x1 = poly1(:,1);  
x2 = poly2(:,1)';
y1 = poly1(:,2);  
y2 = poly2(:,2)';

% differentiate coordinate arrays
dx1 = diff(x1); dy1 = diff(y1);
dx2 = diff(x2); dy2 = diff(y2);

% Determine 'signed distances'
S1 = dx1 .* y1(1:end-1) - dy1 .* x1(1:end-1);
S2 = dx2 .* y2(1:end-1) - dy2 .* x2(1:end-1);

C1 = feval(hF, D(bsxfun(@times,dx1,y2) - bsxfun(@times,dy1,x2), S1), 0);
C2 = feval(hF, D((bsxfun(@times,y1,dx2) - bsxfun(@times,x1,dy2))', S2'), 0)';

% Obtain the segments where an intersection is expected
[i, j] = find(C1 & C2); 

% Process case of no intersection
if isempty(i)
    pts = zeros(0, 2);
    return;
end

% Transpose and prepare for output
i=i'; dx2=dx2'; dy2=dy2'; S2 = S2';
L = dy2(j).*dx1(i) - dy1(i).*dx2(j);

% Avoid divisions by zero
i = i(L~=0);
j = j(L~=0);
L = L(L~=0);

% Solve system of eqs to get the common points
res = [dx2(j).*S1(i) - dx1(i).*S2(j), dy2(j).*S1(i) - dy1(i).*S2(j)] ./ [L L];
pts = unique(res, 'rows');

% Innre function computing a kind of cross-product
function u = D(x,y)
    u = bsxfun(@minus, x(:,1:end-1), y) .* bsxfun(@minus, x(:,2:end), y);
end

end