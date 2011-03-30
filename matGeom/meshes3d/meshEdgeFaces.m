function edgeFaces = meshEdgeFaces(vertices, edges, faces) %#ok<INUSL>
%MESHEDGEFACES Compute index of faces adjacent to each edge of a mesh
%
%   EF = meshEdgeFaces(V, E, F)
%
%   Example
%   meshEdgeFaces
%
%   See also
%   meshes3d
%
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
    for i=1:Nf
        face = faces(i, :);
        processFace(face, i)
    end
elseif iscell(faces)
    Nf = length(faces);
    for i=1:Nf
        face = faces{i};
        processFace(face, i)
    end
end

    function processFace(face, indFace)
        for j = 1:length(face)
            % build edge: array of vertices
            currentEdge = [face(j) face(mod(j, length(face))+1)];
            
            % avoid the case of faces with last vertex equal to the first
            % one
            if currentEdge(1)==currentEdge(2)
                continue;
            end
            
            % find index of current edge within edge array
            b1 = ismember(edges, currentEdge, 'rows');
            indEdge = find(b1);
            if isempty(indEdge)
                b2 = ismember(edges, currentEdge([2 1]), 'rows');
                indEdge = find(b2);
            end
            
            % check up
            if isempty(indEdge)
                warning('geom3d:ElementNotFound', ...
                    'Edge %d of face %d was not found in edge array', ...
                    j, indFace);
                continue;
            end
            
            updateEdgeFaces(indEdge, i);
        end
    end

    function updateEdgeFaces(indEdge, indFace)
        % stores index of current face with found edge
        if edgeFaces(indEdge, 1)==0
            edgeFaces(indEdge, 1) = indFace;
        elseif edgeFaces(indEdge, 2)==0
            edgeFaces(indEdge, 2) = indFace;
        else
            error('Edge %d has more than 2 adjacent faces', indEdge);
        end
    end
end