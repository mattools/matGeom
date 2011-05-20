function varargout = grMergeMultipleNodes(varargin)
%GRMERGEMULTIPLENODES Simplify a graph by merging multiple nodes
%
%   OUTPUT = grMergeMultipleNodes(INPUT);
%   simplify the graph INPUT, and return the result in the graph OUTPUT.
%   format for input can be one of
%   nodes, edges
%
%   Two steps in the procedure :
%   * first remove multiple nodes. find all nodes with same coords, and
%       keep only one
%   * remove edges that link same nodes
%
%   -----
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 09/08/2004.
%



%% process input arguments

n = [];
e = [];
f = [];

% extract data of the graph
var = varargin{1};
if iscell(var)
    % graph is stored as a cell array : first cell is nodes, second one is
    % edges, and third is faces
    n = var{1};
    if length(var)>1
        e = var{2};
    end
    if length(var)>2
        f = var{3};
    end
elseif isstruct(var)
    % graph is stored as a structure, with fields 'nodes', 'edges', and
    % eventually 'faces'.
    n = var.nodes;
    e = var.edges;
    if isfield(var, 'faces')
        f = var.faces;
    end
elseif length(varargin)>1
    % graph is stored as set of variables : nodes, edges, and eventually
    % faces
    n = varargin{1};
    e = varargin{2};
    
    if length(varargin)==3
        f = varargin{3};
    end
end

  
%% Main processing

% simplify graph to remove multiple nodes, and adapt edges and faces
% indices

% simplify nodes
[n, i, j] = unique(n, 'rows'); %#ok<ASGLU>

% change edges indices and remove double edges (undirected graph)
for i = 1:length(e(:))
    e(i) = j(e(i)); %#ok<AGROW>
end
e = unique(sort(e, 2), 'rows');

% change faces indices
if iscell(f)
    % faces stored as cell array (irregular mesh)
	for k = 1:length(f)
        face = f{k};
        for i = 1:length(face(:))
            face(i) = j(face(i));
        end
        f{k} = face; %#ok<AGROW>
	end 
else
    % faces indices stored as regular array (square or triangle mesh).
    for i = 1:length(f(:))
        f(i) = j(f(i)); %#ok<AGROW>
    end
end


%% process output depending on how many arguments are needed

if nargout == 1
    out{1} = n;
    out{2} = e;
    varargout{1} = out;
end

if nargout == 2
    varargout{1} = n;
    varargout{2} = e;
end

if nargout == 3
    varargout{1} = n;
    varargout{2} = e;
    varargout{3} = f;
end

