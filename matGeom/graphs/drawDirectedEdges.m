function varargout = drawDirectedEdges(p, e, varargin)
%DRAWDIRECTEDEDGES Draw edges with arrow indicating direction
% 
%   usage:
%   drawDirectedEdges(NODES, EDGES);
%
%   drawDirectedEdges(NODES, EDGES, STYLE);
%   specifies style of arrrows. Can be one of:
%   'left'
%   'right'
%   'arrow'
%   'triangle'
%   'fill'
%
%   drawDirectedEdges(NODES, EDGES, STYLE, DIRECT) : also specify the base
%   direction of all edges. DIRECT is true by default. If DIRECT is false
%   all edges are inverted.
%   
%   H = drawDirectedEdges(NODES, EDGES) : return handles to each of the
%   lines created.
%
%   TODO: now only style 'arrow' is implemented ...
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 12/03/2003.
%

%   HISTORY


b=1;

if ~isempty(varargin)
    b = varargin{1};
end

h = zeros(length(e),1);
hold on;
for l=1:length(e)
    p1 = e(l, 1);
    p2 = e(l, 2);
    h(l*4) = line([p(p1,1) p(p2,1)], [p(p1,2) p(p2,2)]);
    
    % position of middles of edge
    xm = (p(p1,1) + p(p2,1))/2;
    ym = (p(p1,2) + p(p2,2))/2;
    
    % orientation of edge
    theta = atan2(p(p2,2) - p(p1,2), p(p2,1) - p(p1,1)) + (b==0)*pi;
    
    % pin of the arrow
    xa0 = xm + 10*cos(theta);
    ya0 = ym + 10*sin(theta);
    
    % right side of the arrow
    xa1 = xm + 3*cos(theta-pi/2);
    ya1 = ym + 3*sin(theta-pi/2);
    
    % left side of the arrow
    xa2 = xm + 3*cos(theta+pi/2);
    ya2 = ym + 3*sin(theta+pi/2);
    
    h(l*4+1) = line([xa1 xa0], [ya1 ya0]);
    h(l*4+2) = line([xa2 xa0], [ya2 ya0]);
end

if nargout==1
    varargout(1) = {h};
end
