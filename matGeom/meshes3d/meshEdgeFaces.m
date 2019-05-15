function edgeFaces = meshEdgeFaces(vertices, edges, faces) %#ok<INUSL>
%MESHEDGEFACES Compute index of faces adjacent to each edge of a mesh.
%
%   EF = meshEdgeFaces(V, E, F)
%   Compute index array of faces adjacent to each edge of a mesh.
%   V, E and F define the mesh: V is vertex array, E contains vertex
%   indices of edge extremities, and F contains vertex indices of each
%   face, either as a numerical array or as a cell array.
%   The result EF has as many rows as the number of edges, and two column.
%   The first column contains index of faces located on the left of the
%   corresponding edge, whereas the second column contains index of the
%   face located on the right. Some indices may be 0 if the mesh is not
%   'closed'.
%   
%   Note: a faster version is available for triangular meshes.
%
%   Example
%   meshEdgeFaces
%
%   See also
%   meshes3d, trimeshEdgeFaces, meshDihedralAngles, polyhedronMeanBreadth

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

Ne = size(edges, 1);

% indices of faces adjacent to each edge
edgeFaces = zeros(Ne, 2);

% different method for extracting current face depending if faces are
% stored as index 2D array or as cell array of 1D arrays.
if isnumeric(faces)
    Nf = size(faces, 1);
    for i = 1:Nf
        face = faces(i, :);
        processFace(face, i)
    end
elseif iscell(faces)
    Nf = length(faces);
    for i = 1:Nf
        face = faces{i};
        processFace(face, i)
    end
end

    function processFace(face, indFace)
        % iterate on face edges
        for j = 1:length(face)
            % build edge: array of vertices
            j2 = mod(j, length(face)) + 1;
            
            % do not process edges with same vertices
            if face(j) == face(j2)
                continue;
            end
            
            % vertex indices of current edge
            currentEdge = [face(j) face(j2)];
            
            % find index of current edge, assuming face is left-located
            b1 = ismember(edges, currentEdge, 'rows');
            indEdge = find(b1);
            if ~isempty(indEdge)
                if edgeFaces(indEdge, 1) ~= 0
                    error('meshes3d:IllegalTopology', ...
                        'Two faces were found on left side of edge %d ', indEdge);
                end
                
                edgeFaces(indEdge, 1) = indFace;
                continue;
            end
                
            % otherwise, assume the face is right-located
            b2 = ismember(edges, currentEdge([2 1]), 'rows');
            indEdge = find(b2);
            if ~isempty(indEdge)
                if edgeFaces(indEdge, 2) ~= 0
                    error('meshes3d:IllegalTopology', ...
                        'Two faces were found on left side of edge %d ', indEdge);
                end
                
                edgeFaces(indEdge, 2) = indFace;
                continue;
            end
            
            % If face was neither left nor right, error
            warning('meshes3d:IllegalTopology', ...
                'Edge %d of face %d was not found in edge array', ...
                j, indFace);
            continue;
        end
    end

end
