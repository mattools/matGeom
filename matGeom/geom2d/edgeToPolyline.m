function poly = edgeToPolyline(edge, N)
%EDGETOPOLYLINE Convert an edge to a polyline with a given number of segments
%
%   POLY = edgeToPolyline(EDGE, N)
%   
%   Example
%     edge = [10 20 60 40];
%     poly = edgeToPolyline(edge, 10);
%     drawEdge(edge, 'lineWidth', 2);
%     hold on
%     drawPoint(poly);
%     axis equal;
%
%   See also
%     edges2d, drawEdge, drawPolyline   
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-11-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

if N < 1
    error('number of segments must be greater than 1');
end


if length(edge) == 4
    % case of planar edges
    p1 = edge(1:2);
    p2 = edge(3:4);
    poly = [linspace(p1(1), p2(1), N+1)' linspace(p1(2), p2(2), N+1)'];
    
else
    % case of 3D edges
    p1 = edge(1:3);
    p2 = edge(4:6);
    poly = [...
        linspace(p1(1), p2(1), N+1)' ...
        linspace(p1(2), p2(2), N+1)' ...
        linspace(p1(3), p2(3), N+1)'];
end
