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
% E-mail: david.legland@grignon.inra.fr
% Created: 2011-06-28, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2022 INRA - Cepia Software Platform

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
    % all faces have same number of vertices
    nVF = size(faces,2);
    e = nchoosek(1:nVF,2);
    A = sparse(faces(:,e(:,1)),faces(:,e(:,2)),1,max(faces(:)),max(faces(:)));
    [EI,EJ] = find(tril(A+A'));
    edges = [EJ EI];
    
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

    % keep only unique edges, and return sorted result
    edges = sortrows(unique(sort(edges, 2), 'rows'));
end