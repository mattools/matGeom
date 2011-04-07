function [cVertices cFaces] = clipMeshVertices(vertices, faces, box)
%CLIPMESHVERTICES Clip vertices of a surfacic mesh and remove outer faces
%
%   output = clipMeshVertices(input)
%
%   Example
%   clipMeshVertices
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-04-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

if isstruct(vertices)
    box = faces;
    faces = vertices.faces;
    vertices = vertices.vertices;
end

[cVertices indVertices] = clipPoints3d(vertices, box);


% for face indices relabeling
refInds = zeros(size(indVertices));
for i = 1:length(indVertices)
    refInds(indVertices(i)) = i;
end


if isnumeric(faces)
    % Faces given as numeric array
    indFaces = sum(~ismember(faces, indVertices), 2) == 0;
    cFaces = refInds(faces(indFaces, :));
    
elseif iscell(faces)
    % Faces given as cell array
    nFaces = length(faces);
    indFaces = false(nFaces, 1);
    for i = 1:nFaces
        indFaces(i) = sum(~ismember(faces{i}, indVertices), 2) == 0;
    end
    cFaces = faces(indFaces, :);
    
    % re-label indices of face vertices
    for i = 1:length(cFaces)
        cFaces{i} = refInds(cFaces{i});
    end
    
end
