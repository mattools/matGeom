function varargout = drawDirectedEdges(nodes, edges, varargin)
%DRAWDIRECTEDEDGES Draw edges with arrow indicating direction.
% 
%   usage:
%   drawDirectedEdges(NODES, EDGES);
%   Draw edges joining nodes at position NODES, using a small arrow mark to
%   depict the direction of the edges?
%
%
%   drawDirectedEdges(NODES, EDGES, DIRECT)
%   Also specifies the base direction of all edges. DIRECT is true by
%   default. If DIRECT is false all edges are inverted.
%   
%   H = drawDirectedEdges(NODES, EDGES)
%   Returns handles to each of the lines created.
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-03-12
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

% determinate direction of arrows
direct = true;
if ~isempty(varargin)
    direct = varargin{1};
end

% prepare display
hold on;

% iterate on edges to draw
h = zeros(length(edges),1);
for ie = 1:length(edges)
    p1 = edges(ie, 1);
    p2 = edges(ie, 2);
    h(ie*4) = line([nodes(p1,1) nodes(p2,1)], [nodes(p1,2) nodes(p2,2)]);
    
    % position of middles of edge
    xm = (nodes(p1,1) + nodes(p2,1))/2;
    ym = (nodes(p1,2) + nodes(p2,2))/2;
    
    % orientation of edge
    theta = atan2(nodes(p2,2) - nodes(p1,2), nodes(p2,1) - nodes(p1,1)) + (direct==0)*pi;
    
    % pin of the arrow
    xa0 = xm + 10*cos(theta);
    ya0 = ym + 10*sin(theta);
    
    % right side of the arrow
    xa1 = xm + 3*cos(theta-pi/2);
    ya1 = ym + 3*sin(theta-pi/2);
    
    % left side of the arrow
    xa2 = xm + 3*cos(theta+pi/2);
    ya2 = ym + 3*sin(theta+pi/2);
    
    h(ie*4+1) = line([xa1 xa0], [ya1 ya0]);
    h(ie*4+2) = line([xa2 xa0], [ya2 ya0]);
end

if nargout == 1
    varargout(1) = {h};
end
