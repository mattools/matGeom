function varargout = drawGraphEdges(varargin)
%DRAWGRAPHEDGES Draw edges of a graph
%
%   DRAWGRAPHEDGES(NODES, EDGES) 
%   draw a graph specified by a set of nodes (array N*2 or N*3,
%   corresponding to coordinate of each node), and a set of edges (an array
%   Ne*2, containing for each edge the first and the second node).
%   Default drawing is a red circle for nodes and a blue line for edges.
%
%
%   DRAWGRAPHEDGES(..., SEDGES)
%   specify the draw mode for each element, as in the classical 'plot'
%   function. To not display some elements, uses 'none'.
%
%
%   H = DRAWGRAPHEDGES(...) 
%   return handle to the set of edges.
%   
%   See also drawGraph
%
% ------
% Author: David Legland
% e-mail: david.legland@jouy.inra.fr
% Created: 2005-11-24
% Copyright 2005 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY

% initialisations
e = [];

se = '-b';      % edges are blue lines


% ===============================================================
% process input arguments

if nargin==0
    help drawGraphEdges;
    return;
end

% ---------------------------------------------------------------
% First extract the graph structure

var = varargin{1};
if iscell(var)
    % TODO: should consider array of graph structures.
    % graph is stored as a cell array : first cell is nodes, second one is
    % edges, and third is faces
    n = var{1};
    if length(var)>1
        e = var{2};
    end
    varargin = varargin(2:length(varargin));
elseif isstruct(var)
    % graph is stored as a structure, with fields 'nodes', 'edges'
    n = var.nodes;
    e = var.edges;
    varargin = varargin(2:length(varargin));
else
    % graph is stored as set of variables : nodes, edges
    n = varargin{1};
    e = varargin{2};
    varargin = varargin(3:length(varargin));   
end


% ---------------------------------------------------------------
% extract drawing style 

if ~isempty(varargin)
    se = varargin{2};
end


% ===============================================================
% main drawing processing

hold on;

if size(n, 2)==2
    % Draw 2D Edges ----------------------
    if ~strcmp(se, 'none') && size(e, 1)>0
        he = plot([n(e(:,1),1) n(e(:,2),1)]', [n(e(:,1),2) n(e(:,2),2)]', se);
    end
    
elseif size(n, 2)==3
     % Draw 3D edges ----------------------
    if ~strcmp(se, 'none') && size(e, 1)>0
        he = plot3([n(e(:,1),1) n(e(:,2),1)]', [n(e(:,1),2) n(e(:,2),2)]', [n(e(:,1),3) n(e(:,2),3)]', se);
    end
end


% ===============================================================
% format output arguments

if nargout == 1
    varargout = {he};
end
