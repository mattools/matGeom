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
% E-mail: david.legland@inrae.fr
% Created: 2011-06-28, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2024 INRA - Cepia Software Platform

%% Process input arguments

if isstruct(faces) && isfield(faces, 'faces')
    % if input is a mesh structure, extract the 'faces' field
    faces = faces.faces;
elseif nargin > 1
    % if two arguments are given, keep the second one
    faces = varargin{1};
end


if isnumeric(faces)
    %% Process faces given as numeric array
    % e = nchoosek(1:3,2);
    nVF = size(faces, 2);
    e = [(1:nVF)' [2:nVF 1]'];
    nv = max(faces(:));
    A = sparse(faces(:,e(:,1)), faces(:,e(:,2)), 1, nv, nv);
    [EI, EJ] = find(tril(A + A'));
    edges = [EJ EI];
    
elseif iscell(faces)
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

    % keep only unique edges, and return sorted result
    edges = sortrows(unique(sort(edges, 2), 'rows'));
else
    error('Input argument must be either a Nf-by-Nvf numeric array, or a cell array');
end
