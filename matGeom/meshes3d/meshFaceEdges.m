function FE = meshFaceEdges(vertices, edges, faces)
%MESHFACEEDGES Computes edge indices of each face.
%
%   FE = meshFaceEdges(V, E, F)
%   Returns a 1-by-NF cell array containing for each face, the set of edge
%   indices corresponding to adjacent edges.
%
%   Example
%   meshFaceEdges
%
%   See also
%     meshes3d, meshEdgeFaces

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2013-08-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

nFaces = meshFaceNumber(vertices, faces);

FE = cell(nFaces, 1);

% impose ordering of edge indices
edges = sort(edges, 2);

for iFace = 1:nFaces
    % extract vertex indices of current face
    face = meshFace(faces, iFace);
    nv = length(face);
    
    % for each couple of adjacent vertices, find the index of the matching
    % row in the edges array
    fei = zeros(1, nv);
    for iEdge = 1:nv
        % compute index of each edge vertex
        edge = sort([face(iEdge) face(mod(iEdge, nv) + 1)]);
        v1 = edge(1);
        v2 = edge(2);

        % find the matching row 
        ind = find(edges(:,1) == v1 & edges(:,2) == v2);
        fei(iEdge) = ind;
        
    end
    FE{iFace} = fei;
end
