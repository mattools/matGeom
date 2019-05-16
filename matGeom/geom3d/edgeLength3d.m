function len = edgeLength3d(edge, varargin)
%EDGELENGTH3D Return the length of a 3D edge.
%
%   L = edgeLength3D(EDGE);  
%   Returns the length of a 3D edge, with following representation:
%   [x1 y1 z1 x2 y2 z2].
%
%   Example
%     p1 = [1 1 1];
%     p2 = [3 4 5];
%     edge = createEdge3d(p1, p2);
%     edgeLength3d(edge)
%     ans =
%         5.3852
%   
%   See also
%     edges3d, createEdge3d, drawEdge3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-08-29,    using Matlab 9.4.0.813654 (R2018a)
% Copyright 2018 INRA - Cepia Software Platform.

if nargin == 1
    dp = edge(:, 4:6) - edge(:, 1:3);
else
    dp = varargin{1} - edge;
end

len = hypot(hypot(dp(:,1), dp(:,2)), dp(:,3));
