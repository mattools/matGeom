function varargout = mergeGraphs(varargin)
%MERGEGRAPHS Merge two graphs, by adding nodes, edges and faces lists. 
%
%   
%
%   -----
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 09/08/2004.
%


simplify = false;


edges = {}; edges2 = {};
faces = {}; faces2 = {}; 


% ===============================================================
% process input arguments

% ---------------------------------------------------------------
% extract simplify tag

var = varargin{nargin};
if ischar(var)
	if strcmp(var, 'simplify');
        simplify = true;
        varargin = varargin(1:length(varargin)-1);
	end
end


% ---------------------------------------------------------------
% extract data of first graph

var = varargin{1};
if iscell(var)
    % graph is stored as a cell array : first cell is nodes, second one is
    % edges, and third is faces
    nodes = var{1};
    if length(var)>1
        edges = var{2};
    end
    if length(var)>2
        faces = var{3};
    end
    varargin = varargin(2:length(varargin));
    
elseif isstruct(var)
    % graph is stored as a structure, with fields 'nodes', 'edges', and
    % eventually 'faces'.
    nodes = var.nodes;
    edges = var.edges;
    if isfield(var, 'faces')
        faces = var.faces;
    end
    varargin = varargin(2:length(varargin));
    
elseif length(varargin)>2
    % graph is stored as set of variables : nodes, edges, and eventually
    % faces
    nodes = varargin{1};
    edges = varargin{2};
    
    if length(varargin)==3
        % last argument describe graph 2
        varargin = varargin(3);
    else
        if length(varargin)~=4 || ~isnumeric(varargin{4})
            % third argument is faces of graph 1
            faces = varargin{3};
            varargin = varargin(4:length(varargin));
        else
            varargin = varargin(3:length(varargin));
        end
    end
    
else
    error('Error in passing arguments in mergeGraphs');
end

  
% ---------------------------------------------------------------    
% extract data of second graph

var = varargin{1};
if iscell(var)
    % graph is stored as a cell array : first cell is nodes, second one is
    % edges, and third is faces
    nodes2 = var{1};
    if length(var)>1
        edges2 = var{2};
    end
    if length(var)>2
        faces2 = var{3};
    end
    
elseif isstruct(var)
    % graph is stored as a structure, with fields 'nodes', 'edges', and
    % eventually 'faces'.
    nodes2 = var.nodes;
    edges2 = var.edges;
    if isfield(var, 'faces')
        faces2 = var.faces;
    end
    
elseif length(varargin)>1
    % graph is stored as set of variables : nodes, edges, and eventually
    % faces
    nodes2 = varargin{1};
    edges2 = varargin{2};
    
    if length(varargin)>2
        % last argument describe graph 2
        faces2 = varargin{3};
    end
    
else
    error('Error in passing arguments in mergeGraphs');
end


% ===============================================================
% Main algorithm

% eventually convert faces
if ~iscell(faces)
    f = cell(size(faces, 1), 1);
    for i=1:size(faces, 1)
        f{i} = faces(i,:);
    end
    faces = f;
end

edges = [edges ; edges2 + size(nodes, 1)];
if iscell(faces2)
	for i=1:length(faces2)
        faces{length(faces)+1} = faces2{i} + size(nodes, 1); %#ok<AGROW>
	end
else
    % TODO
end
nodes = [nodes; nodes2];

if simplify
    if ~isempty(faces)
        [nodes edges faces] = grSimplifyBranches(nodes, edges, faces);
    else
        [nodes edges] = grSimplifyBranches(nodes, edges);
    end
end


% ===============================================================
% process output depending on how many arguments are needed

if nargout == 1
    graph.nodes = nodes;
    graph.edges = edges;
    if ~isempty(faces)
        graph.faces = faces;
    end
    varargout{1} = graph;
end

if nargout == 2
    varargout{1} = nodes;
    varargout{2} = edges;
end

if nargout == 3
    varargout{1} = nodes;
    varargout{2} = edges;
    varargout{3} = faces;
end


