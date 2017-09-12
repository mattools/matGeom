function varargout = drawGraphFaces(varargin)
%DRAWGRAPHFACES Draw faces of a graph
%
%   DEPRECATED. Replaced by fillGraphFaces
%
%   
%   See also
%   graphs, fillGraphFaces
%   

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2005-11-24
% Copyright 2005 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).

%   HISTORY
%   2017-09-04 code cleanup

warning('matGeom:deprecated', ...
    'function drawGraphFaces is obsolete, use fillGraphFaces instead');

%% Initialisations

% drawing style for filling faces. Default is cyan.
faceColor = 'c';


%% Process input arguments

% if called without argument, display usage 
if nargin == 0
    help drawGraphFaces;
    return;
end

% Extract the structure of the graph
var = varargin{1};
if iscell(var)
    % graph is stored as a cell array : first cell is nodes, second one is
    % edges, and third one is faces
    n = var{1};
    if length(var) > 2
        f = var{3};
    end
    varargin(1) = [];
    
elseif isstruct(var)
    % graph is stored as a structure, with fields 'nodes', 'edges', and
    % eventually 'faces'.
    n = var.nodes;
    if isfield(var, 'faces')
        f = var.faces;
    end
    varargin(1) = [];
    
else
    % graph is stored as set of variables: nodes, edges, and eventually
    % faces
    n = varargin{1};
    
    % extract faces input argument
    if length(varargin) > 2 && ~ischar(varargin{3})
        f = varargin{3};
        varargin(1:3) = [];
    else
        f = varargin{2};
        varargin(1:2) = [];
    end
        
end

% extract drawing style 
if ~isempty(varargin)
    faceColor = varargin{1};
end

% process special case of 'none' option, that can be used in a call from
% the drawGraph function
if strcmp(faceColor, 'none')
    return;
end


%% Main drawing processing

% setup hold to display several faces
hold on;


if size(n, 2) == 3
    % use a zbuffer to avoid display pbms.
    set(gcf, 'renderer', 'zbuffer');
end

if iscell(f)
    % each face is contained in a cell.
    for fi = 1:length(f)
        hf(fi) = patch('Faces', f{fi}, 'Vertices', n, 'FaceColor', faceColor, 'EdgeColor', 'none');  %#ok<AGROW>
    end
else
    % process faces as a NF-by-P array. NF i the number of faces,
    % and all faces have the same number P of vertices (nodes).
    hf = patch('Faces', f, 'Vertices', n, 'FaceColor', faceColor, 'EdgeColor', 'none');
end


%% format output arguments

if nargout == 1
    varargout{1} = hf;
end
  