function varargout = drawGraphEdges(varargin)
%DRAWGRAPHEDGES Draw edges of a graph
%
%   drawGraphEdges(NODES, EDGES) 
%   Draws a graph specified by a set of nodes (array N-by-2 or N-by-3,
%   corresponding to coordinate of each node), and a set of edges (an array
%   Ne-by-2, containing to the first and the second node of each edge).
%
%   drawGraphEdges(..., SEDGES)
%   Specifies the draw mode for each element, as in the classical 'plot'
%   function.
%   Default drawing is a blue line for edges.
%
%
%   H = drawGraphEdges(...) 
%   return handle to the set of edges.
%   
%   See also 
%   drawGraph
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2005-11-24
% Copyright 2005 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY


%% Input argument processing

% initialisations
e = [];

% check input arguments number
if nargin == 0
    help drawGraphEdges;
    return;
end

% First extract the graph structure
var = varargin{1};
if iscell(var)
    % TODO: should consider array of graph structures.
    % graph is stored as a cell array : first cell is nodes, second one is
    % edges, and third is faces
    n = var{1};
    if length(var) > 1
        e = var{2};
    end
    varargin(1) = [];
    
elseif isstruct(var)
    % graph is stored as a structure, with fields 'nodes', 'edges'
    n = var.nodes;
    e = var.edges;
    varargin(1) = [];
    
else
    % graph is stored as set of variables: nodes + edges
    n = varargin{1};
    e = varargin{2};
    varargin(1:2) = [];
end

% check if there are edges to draw
if size(e, 1) == 0
    return;
end

% setup default drawing style if not specified
if isempty(varargin)
    varargin = {'-b'};
end


%% main drawing processing

if size(n, 2) == 2
    % Draw 2D edges
    x = [n(e(:,1), 1) n(e(:,2), 1)]';
    y = [n(e(:,1), 2) n(e(:,2), 2)]';
    he = plot(x, y, varargin{:});
    
elseif size(n, 2) == 3
    % Draw 3D edges
    x = [n(e(:,1), 1) n(e(:,2), 1)]';
    y = [n(e(:,1), 2) n(e(:,2), 2)]';
    z = [n(e(:,1), 3) n(e(:,2), 3)]';
    he = plot3(x, y, z, varargin{:});
    
end


%% format output arguments

if nargout == 1
    varargout = {he};
end
