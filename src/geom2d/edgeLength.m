function len = edgeLength(varargin)
%EDGELENGTH return length of an edge
%
%   L = edgeLength(EDGE);  
%   Returns the length of an edge, with parametric representation:
%   [x1 y1 x2 y2].
%
%   The function also works for several edges, in this case input is a
%   [N*4] array, containing parametric representation of each edge, and
%   output is a [N*1] array containing length of each edge.
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

nargs = length(varargin);
if nargs == 1
    edge = varargin{1};
    len = sqrt(power(edge(:,3)-edge(:,1), 2) + power(edge(:,4)-edge(:,2), 2));
end
