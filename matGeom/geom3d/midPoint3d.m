function varargout = midPoint3d(varargin)
%MIDPOINT3D Middle point of two 3D points or of a 3D edge.
%
%   MID = midPoint3d(P1, P2)
%   Compute the middle point of the two points P1 and P2.
%
%   MID = midPoint3d(EDGE)
%   Compute the middle point of the edge given by EDGE.
%   EDGE has the format: [X1 Y1 Z1 X2 Y2 Z2], and MID has the format 
%   [XMID YMID ZMID], 
%   with XMID = (X1+X2)/2, YMID = (Y1+Y2)/2 and ZMID = (Z1+Z2)/2.
%
%   [MIDX MIDY] = midPoint3d(...)
%   Return the result as two separate variables or arrays.
%
%   Works also when EDGE is a N-by-6 array, in this case the result is a
%   N-by-3 array containing the midPoint3d of each edge.
%
%
%   Example
%   P1 = [10 20 30];
%   P2 = [30 40 50];
%   % edge input
%   midPoint3d([P1 P2])
%   ans =
%       20  30  40
%
%   % two points input
%   midPoint3d(P1, P2)
%   ans =
%       20  30  40
%
%   % three outputs
%   [xm ym zm] = midPoint3d(P1, P2)
%   xm =
%       20  
%   ym = 
%       30  
%   zm = 
%       40
%
%   See also
%     edges3d, points3d
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-08-08,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

if nargin == 1
    % input is a 3D edge
    edge = varargin{1};
    mid = [mean(edge(:, [1 4]), 2) mean(edge(:, [2 5]), 2) mean(edge(:, [3 6]), 2)];
    
elseif nargin == 2
    % input are two points
    p1 = varargin{1};
    p2 = varargin{2};
    
    % assert inputs are equal
    n1 = size(p1, 1);
    n2 = size(p2, 1);
    if n1>1 && n2==1
        p2 = repmat(p2, n1, 1);
    elseif n2>1 && n1==1
        p1 = repmat(p1, n2, 1);
    elseif n1~=n2
        error('geom3d:midPoint3d', ...
            'Inputs must have same size, or one must have length 1');
    end
    
    % compute middle point
    mid = (p1 + p2) / 2;
end

% process output arguments
if nargout<=1
    varargout{1} = mid;
else
    varargout = {mid(:,1), mid(:,2), mid(:,3)};
end
