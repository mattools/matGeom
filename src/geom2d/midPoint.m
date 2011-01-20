function varargout = midPoint(varargin)
%MIDPOINT Middle point of two points or of an edge
%
%   MID = midPoint(P1, P2)
%   Compute the middle point of the two points P1 and P2.
%
%   MID = midPoint(EDGE)
%   Compute the middle point of the edge given by EDGE.
%   EDGE has the format: [X1 Y1 X2 Y2], and MID has the format [XMID YMID],
%   with XMID = (X1+X2)/2, and YMID = (Y1+Y2)/2.
%
%   [MIDX MIDY] = midPoint(...)
%   Return the result as two separate variables or arrays.
%
%   Works also when EDGE is a N-by-4 array, in this case the result is a
%   N-by-2 array containing the midpoint of each edge.
%
%
%   Example
%   P1 = [10 20];
%   P2 = [30 40];
%   midPoint([P1 P2])
%   ans =
%       20  30
%
%   See also
%   edges2d, points2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

if nargin == 1
    % input is an edge
    edge = varargin{1};
    mid = [mean(edge(:, [1 3]), 2) mean(edge(:, [2 4]), 2)];
    
elseif nargin == 2
    % input are two points
    p1 = varargin{1};
    p2 = varargin{2};
    
    % assert inputs are equal
    n1 = size(p1, 1);
    n2 = size(p2, 1);
    if n1~=n2 && min(n1, n2)>1
        error('geom2d:midPoint', ...
            'Inputs must have same size, or one must have length 1');
    end
    
    % compute middle point
    mid = bsxfun(@plus, p1, p2) / 2;
end

% process output arguments
if nargout<=1
    varargout{1} = mid;
else
    varargout = {mid(:,1), mid(:,2)};
end
