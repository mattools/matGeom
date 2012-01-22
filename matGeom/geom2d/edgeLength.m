function len = edgeLength(varargin)
%EDGELENGTH Return length of an edge
%
%   L = edgeLength(EDGE);  
%   Returns the length of an edge, with parametric representation:
%   [x1 y1 x2 y2].
%
%   The function also works for several edges, in this case input is a
%   N-by-4 array, containing parametric representation of each edge, and
%   output is a N-by-1 array containing length of each edge.
%
%   See also:
%   edges2d, edgeAngle
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 19/02/2004
%

%   HISTORY
%   15/04/2005 changes definition for edge, uses [x1 y1 x2 y2] instead of
%       [x0 y0 dx dy].

%   TODO : specify norm (euclidian, taxi, ...).

if nargin == 1
    % input is an edge [X1 Y1 X2 Y2]
    edge = varargin{1};
    len = hypot(edge(:,3)-edge(:,1), edge(:,4)-edge(:,2));
    
elseif nargin == 2
    % input are two points [X1 Y1] and [X2 Y2]
    p1 = varargin{1};
    p2 = varargin{2};
    len = hypot(p2(:,1)-p1(:,1), p2(:,2)-p1(:,2));
    
end
