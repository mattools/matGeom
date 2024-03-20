function varargout = drawGraph(varargin)
%DRAWGRAPH Draw a graph, given as a set of vertices and edges.
%
%   drawGraph(NODES, EDGES) 
%   Draws a graph specified by a set of nodes (array N-by-2 or N-by-3,
%   corresponding to coordinate of each node), and a set of edges (an array
%   NE-by-2, containing for each edge the first and the second node).
%   Default drawing is a red circle for nodes and a blue line for edges.
%
%   drawGraph(NODES, EDGES, FACES)
%   Also draws faces of the graph as patches.
%
%   drawGraph(GRAPH)
%   Passes argument in a srtucture with at least 2 fields named 'nodes' and
%   'edges', and possibly one field 'faces', corresponding to previously
%   described parameters.
%   GRAPH can also be a cell array, whose first element is node array,
%   second element is edges array, and third element, if present, is faces
%   array.
%
%
%   drawGraph(..., SNODES)
%   drawGraph(..., SNODES, SEDGES)
%   drawGraph(..., SNODES, SEDGES, SFACES)
%   Specifies the draw mode for each element, as in the classical 'plot'
%   function. To not display some elements, uses 'none'.
%
%
%   H = drawGraph(...) 
%   Returns handle to the set of edges.
%   
%   [HN, HE] = drawGraph(...) 
%   Returns handle to the set of nodes and to the set of edges.
%
%   [HN, HE, HF] = drawGraph(...)   
%   Also returns handle to the set of faces.
%   
%   See also 
%   graphs, drawGraphEdges, fillGraphFaces, clipGraph, clipGraphPolygon
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-07-17
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

%% initialisations

% uses empty arrays by default for edges and faces
e = [];
f = [];

% default styles for nodes, edges, and faces

% nodes are drawn as red circles
sn = {'linestyle', 'none', 'color', 'r', 'marker', 'o'};

% edges are drawn as blue lines
se = {'linestyle', '-', 'color', 'b'};

% faces are cyan, their edges are not drawn
sf = {'EdgeColor', 'none', 'Facecolor', 'c'};


%% Process input arguments

% case of a call without arguments
if nargin == 0
    help drawGraph;
    return;
end

% First extract the graph structure

var = varargin{1};
if iscell(var)
    % graph is stored as a cell array: first cell is nodes, second one is
    % edges, and third is faces
    n = var{1};
    if length(var)>1
        e = var{2};
    end
    if length(var)>2
        f = var{3};
    end
    varargin(1) = [];
elseif isstruct(var)
    % graph is stored as a structure, with fields 'nodes', 'edges', and
    % eventually 'faces'.
    n = var.nodes;
    e = var.edges;
    if isfield(var, 'faces')
        f = var.faces;
    end
    varargin(1) = [];
else
    % graph is stored as set of variables: nodes, edges, and eventually
    % faces
    n = varargin{1};
    e = varargin{2};
    varargin(1:2) = [];
    
    if ~isempty(varargin)
        var = varargin{1};
        if isnumeric(var)
            % faces are stored in a numeric array of indices
            f = var;
            varargin(1) = [];
        elseif iscell(var)
            if ~ischar(var{1})
                % faces are stored in a cell array, each cell containing a
                % row vector of indices
                f = var;
                varargin(1) = [];
            end
        end
    end
end

% extract drawing style 

if ~isempty(varargin)
    sn = concatArguments(sn, varargin{1});
end

if length(varargin)>1
    se = concatArguments(se, varargin{2});
end

if length(varargin)>2
    sf = concatArguments(sf, varargin{3});
end



%% Main drawing processing

hold on;

if size(n, 2) == 2
    % Draw a 2 dimensional graph

    % Draw faces of the graph
    if ~strcmp(sf{1}, 'none') && ~isempty(f)
        if iscell(f)
            % each face is contained in a cell.
            hf = zeros(size(f));
            for fi = 1:length(f)
                hf(fi) = patch('Faces', f{fi}, 'Vertices', n, sf{:}); 
            end
        else
            % process faces as an Nf*N array. Nf is the number of faces,
            % and all faces have the same number of vertices (nodes).
            hf = patch('Faces', f, 'Vertices', n, sf{:}); 
        end
    end
    
    % Draw 2D Edges
    if ~strcmp(se{1}, 'none') && size(e, 1) > 0
        he = plot([n(e(:,1),1) n(e(:,2),1)]', [n(e(:,1),2) n(e(:,2),2)]', se{:});
    end

    % Draw 2D nodes
    if ~strcmp(sn{1}, 'none')
        hn = plot(n(:,1), n(:,2), sn{:});
    end
    
    
elseif size(n, 2)==3
    % Draw a 3 dimensional graph

    % use a zbuffer to avoid display pbms.
    set(gcf, 'renderer', 'zbuffer');

    % Draw 3D Faces
    if ~strcmp(sf{1}, 'none')
        if iscell(f)
            % each face is contained in a cell.
            hf = zeros(size(f));
            for fi = 1:length(f)
                hf(fi) = patch('Faces', f{fi}, 'Vertices', n, sf{:}); 
            end
        else
            % process faces as an Nf*N array. Nf i the number of faces,
            % and all faces have the same number of vertices (nodes).
            hf = patch('Faces', f, 'Vertices', n, sf{:}); 
        end
    end
       
    % Draw 3D edges
    if ~strcmp(se{1}, 'none') && size(e, 1) > 0
        he = line(...
            [n(e(:,1),1) n(e(:,2),1)]', ...
            [n(e(:,1),2) n(e(:,2),2)]', ...
            [n(e(:,1),3) n(e(:,2),3)]', ...
            se{:});
    end
    
    % Draw 3D nodes
    if ~strcmp(sn{1}, 'none')
        hn = plot3(n(:,1), n(:,2), n(:,3), sn{:});
    end
    
end


%% Format output arguments

% return handle to edges
if nargout==1
    varargout{1} = he;
end

% return handle to nodes and edges
if nargout==2
    varargout{1} = hn;
    varargout{2} = he;
end

% return handle to nodes, edges and faces
if nargout==3
    varargout{1} = hn;
    varargout{2} = he;
    varargout{3} = hf;
end



end

function res = concatArguments(in1, in2)
% in1 is a cell array already initialized
% in2 is an argument that can be:
%   - empty
%   - the string 'none'
%   - another cell array

if isempty(in2)
    res = in1;
    return;
end

if ischar(in2)
    if strcmp('none', in2)
        res = {'none'};
        return;
    end
end

if iscell(in1)
    res = [in1(:)' in2(:)'];
else
    res = [{in1} in2(:)];
end

end
