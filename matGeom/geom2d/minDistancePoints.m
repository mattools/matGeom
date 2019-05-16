function varargout = minDistancePoints(p1, varargin)
%MINDISTANCEPOINTS Minimal distance between several points.
%
%   DIST = minDistancePoints(PTS)
%   Returns the minimum distance between all couple of points in PTS. PTS
%   is a N-by-D array of values, N being the number of points and D the
%   dimension of the points.
%
%   DIST = minDistancePoints(PTS1, PTS2)
%   Computes for each point in PTS1 the minimal distance to every point of
%   PTS2. PTS1 and PTS2 are N-by-D arrays, where N is the number of points,
%   and D is the dimension. Dimension must be the same for both arrays, but
%   number of points can be different.
%   The result is an array the same length as PTS1.
%
%
%   DIST = minDistancePoints(..., NORM)
%   Uses a user-specified norm. NORM=2 means euclidean norm (the default), 
%   NORM=1 is the Manhattan (or "taxi-driver") distance.
%   Increasing NORM growing up reduces the minimal distance, with a limit
%   to the biggest coordinate difference among dimensions. 
%   
%
%   [DIST I J] = minDistancePoints(PTS)
%   Returns indices I and J of the 2 points which are the closest. DIST
%   verifies relation:
%   DIST = distancePoints(PTS(I,:), PTS(J,:));
%
%   [DIST J] = minDistancePoints(PTS1, PTS2, ...)
%   Also returns the indices of points which are the closest. J has the
%   same size as DIST. It verifies relation: 
%   DIST(I) = distancePoints(PTS1(I,:), PTS2(J,:));
%   for I comprised between 1 and the number of rows in PTS1.
%
%
%   Examples:
%   % minimal distance between random planar points
%       points = rand(20,2)*100;
%       minDist = minDistancePoints(points);
%
%   % minimal distance between random space points
%       points = rand(30,3)*100;
%       [minDist ind1 ind2] = minDistancePoints(points);
%       minDist
%       distancePoints(points(ind1, :), points(ind2, :))
%   % results should be the same
%
%   % minimal distance between 2 sets of points
%       points1 = rand(30,2)*100;
%       points2 = rand(30,2)*100;
%       [minDists inds] = minDistancePoints(points1, points2);
%       minDists(10)
%       distancePoints(points1(10, :), points2(inds(10), :))
%   % results should be the same
%   
%   See Also
%   points2d, distancePoints, nndist, hausdorffDistance
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Copyright 2009 INRA - Cepia Software Platform.
% created the 15/06/2004.


% HISTORY:
% 22/06/2005 compute sqrt only at the end (faster), and change behaviour
%   for 2 inputs: compute min distance for each point in PTS1. 
%   Also add support for different norms.
% 15/08/2005 make difference when 1 array or 2 arrays of points
% 25/10/2006 also returns indices of closest points
% 30/10/2006 generalize to points of any dimension
% 28/08/2007 code cleanup, add comments and help
% 01/02/2017 complete re-write by JuanPi Carbajal
% 01/02/2017 fix bugs, update code, fix MLInt Warning (D. Legland)
% 01/02/2017 remove use of vech


%% Initialisations

% default norm (euclidean)
n = 2;

% a single array is given
one_array = true;

% process input variables
if nargin == 1
    % specify only one array of points, not the norm
    p2 = p1;
elseif nargin == 2
    if isscalar (varargin{1})
        % specify array of points and the norm
        n   = varargin{1};
        p2  = p1;
    else
        % specify two arrays of points
        p2  = varargin{1};
        one_array = false;
    end
elseif nargin == 3
    % specify two array of points and the norm
    p2        = varargin{1};
    n         = varargin{2};
    one_array = false;
else
    error ('Wrong number of input arguments');
end

% number of points in each array
n1  = size (p1, 1);
n2  = size (p2, 1);

% dimensionality of points
d   = size (p1, 2);


%% Computation of distances

% allocate memory
dist = zeros (n1, n2);

% Compute difference of coordinate for each pair of point (n1-by-n2 array)
% and for each dimension. -> dist is a n1-by-n2 array.
% in 2D: dist = dx.*dx + dy.*dy;
if n == inf
    % infinite norm corresponds to maximum absolute value of differences
    % in 2D: dist = max(abs(dx) + max(abs(dy));
    for i = 1:d
        dist = max (dist, abs(bsxfun (@minus, p1(:,i), p2(:,i).')));
    end
else
    for i = 1:d
        dist = dist + abs (bsxfun (@minus, p1(:,i), p2(:,i).')).^n;
    end
end
% TODO the previous could be optimized when a single array  is given (maybe!)

if ~one_array
    % If two array of points where given
    [minSqDist, ind]    = min (dist, [], 2);
    minDist             = power (minSqDist, 1/n);
    [ind2, ind1]        = ind2sub ([n1 n2], ind);
    
else
    % A single array was given
    dist                = dist + diag (inf (n1,1)); % remove zeros from diagonal
    dist                = dist (tril(true(n1, n1)));
    [minSqDist, ind]    = min (dist); % index on packed lower triangular matrix
    minDist             = power (minSqDist, 1/n);
    
    [ind2, ind1]        = ind2sub_tril (n1, ind);
    ind2 = ind2(1);
    ind1 = ind1(1);
    ind                 = sub2ind ([n1 n1], ind2, ind1);
end


%% format output parameters

% format output depending on number of asked parameters
if nargout <= 1
    varargout{1} = minDist;
    
elseif nargout == 2
    % If two arrays are asked, 'ind' is an array of indices of p2, one for each
    % point in p1, corresponding to the result in minDist
    varargout{1} = minDist;
    varargout{2} = ind;
    
elseif nargout == 3
    % If only one array is asked, minDist is a scalar, ind1 and ind2 are 2
    % indices corresponding to the closest points.
    varargout{1} = minDist;
    varargout{2} = ind1;
    varargout{3} = ind2;
end

end

function [r, c] = ind2sub_tril (N, idx)
% [r, c] = ind2sub_tril (N, idx)
% Convert a linear index to subscripts of a trinagular matrix.
%
% An example of trinagular matrix linearly indexed follows
%
%          N = 4;
%          A = -repmat (1:N,N,1);
%          A = [A repmat (diagind, N,1) - A.'];
%          A = tril(A)
%          => A =
%              1    0    0    0
%              2    5    0    0
%              3    6    8    0
%              4    7    9   10
%
% The following example shows how to convert the linear index `6' in
% the 4-by-4 matrix of the example into a subscript.
%
%          [r, c] = ind2sub_tril (4, 6)
%          => r =  3
%            c =  2
%
% when idx is a row or column matrix of linear indeces then r and
% c have the same shape as idx.
%
% See also
%   ind2sub

endofrow = 0.5 * (1:N) .* (2*N:-1:N + 1);
c = zeros(size(endofrow));
for i = 1:length(endofrow)
    ind = find(endofrow <= idx - 1, 1, 'last') + 1;
    if isempty(ind) 
        ind = 1;
    end
    c(i) = ind;
% c        = lookup (endofrow, idx - 1) + 1;
end
r        = N - endofrow(c) + idx ;

end
