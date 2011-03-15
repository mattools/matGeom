function res = reverseEdge(edge)
%REVERSEEDGE Intervert the source and target vertices of edge
%
%   REV = reverseEdge(EDGE);
%   Returns the opposite edge of EDGE.
%   EDGE has the format [X1 Y1 X2 Y2]. The resulting edge REV has value
%   [X2 Y2 X1 Y1];
%
%   See also:
%   edges2d, createEdge, reverseLine
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-05-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

res = [edge(:,3:4) edge(:,1:2)];