function edges = meshEdges(faces, varargin)
%MESHEDGES Computes array of edge vertex indices from face array.
%
%   EDGES = meshEdges(FACES);
%
%   Example
%     meshEdges
%
%   See also
%     meshes3d, meshEdgeFaces, meshFaceEdges

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-28,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

%   HISTORY
%   2013-08-22 rename from computeMeshEdges to meshEdges, add more control
%       on inputs

%% Process input arguments

if isstruct(faces) && isfield(faces, 'faces')
    % if input is a mesh structure, extract the 'faces' field
    faces = faces.faces;
elseif nargin > 1
    % if two arguments are given, keep the second one
    faces = varargin{1};
end


if ~iscell(faces)
    %% Process faces given as numeric array
    % all faces have same number of vertices, stored in nVF variable
    
    % compute total number of edges
    nFaces  = size(faces, 1);
    nVF     = size(faces, 2);
    nEdges  = nFaces * nVF;
    
    % create all edges (with double ones)
    edges = zeros(nEdges, 2);
    for i = 1:nFaces
        f = faces(i, :);
        edges(((i-1)*nVF+1):i*nVF, :) = [f' f([2:end 1])'];
    end
    
else
    %% faces are given as a cell array
    % faces may have different number of vertices
    
    % number of faces
    nFaces  = length(faces);
    
    % compute the number of edges
    nEdges = 0;
    for i = nFaces
        nEdges = nEdges + length(faces{i});
    end
    
    % allocate memory
    edges = zeros(nEdges, 2);
    ind = 0;
    
    % fillup edge array
    for i = 1:nFaces
        % get vertex indices, ensuring horizontal array
        f = faces{i}(:)';
        nVF = length(f);
        edges(ind+1:ind+nVF, :) = [f' f([2:end 1])'];
        ind = ind + nVF;
    end
    
end

% keep only unique edges, and return sorted result
edges = sortrows(unique(sort(edges, 2), 'rows'));
