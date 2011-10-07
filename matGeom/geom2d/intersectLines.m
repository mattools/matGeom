function point = intersectLines(line1, line2, varargin)
%INTERSECTLINES Return all intersection points of N lines in 2D
%
%   PT = intersectLines(L1, L2);
%   returns the intersection point of lines L1 and L2. L1 and L2 are 1-by-4
%   row arrays, containing parametric representation of each line (in the
%   form [x0 y0 dx dy], see 'createLine' for details).
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
%   2004-02-19 add support for multiple lines.
%   2007-03-08 update doc
%   2011-10-07 code cleanup


%% Process input arguments

% extract tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% check size of each input
N1 = size(line1, 1);
N2 = size(line2, 1);
N = max(N1, N2);
if N1 ~= N2 && N1*N2 ~= N
    error('matGeom:IntersectLines:IllegalArgument', ...
        'The two input arguments must have same number of lines');
end


%% Check parallel and colinear lines

% coordinate differences of origin points
dx = bsxfun(@minus, line2(:,1), line1(:,1));
dy = bsxfun(@minus, line2(:,2), line1(:,2));

% indices of parallel lines
denom = line1(:,3) .* line2(:,4) - line2(:,3) .* line1(:,4);
par = abs(denom) < tol;

% indices of colinear lines
col = abs(dx .* line1(:,4) - dy .* line1(:,3)) < tol & par ;

% initialize result array
x0 = zeros(N, 1);
y0 = zeros(N, 1);

% initialize result for parallel lines
x0(col) = Inf;
y0(col) = Inf;
x0(par & ~col) = NaN;
y0(par & ~col) = NaN;

% in case all line couples are parallel, return
if all(par)
    point = [x0 y0];
    return;
end


%% Extract coordinates of itnersecting lines

% indices of intersecting lines
inds = ~par;

% extract base coordinates of first lines
if N1 > 1
    line1 = line1(inds,:);
end
x1 =  line1(:,1);
y1 =  line1(:,2);
dx1 = line1(:,3);
dy1 = line1(:,4);

% extract base coordinates of second lines
if N2 > 1
    line2 = line2(inds,:);
end
x2 =  line2(:,1);
y2 =  line2(:,2);
dx2 = line2(:,3);
dy2 = line2(:,4);

% re-compute coordinate differences of origin points
dx = bsxfun(@minus, line2(:,1), line1(:,1));
dy = bsxfun(@minus, line2(:,2), line1(:,2));


%% Compute intersection points

denom = denom(inds);
x0(inds) = (x2 .* dy2 .* dx1 - dy .* dx1 .* dx2 - x1 .* dy1 .* dx2) ./ denom ;
y0(inds) = (dx .* dy1 .* dy2 + y1 .* dx1 .* dy2 - y2 .* dx2 .* dy1) ./ denom ;

% concatenate result
point = [x0 y0];
