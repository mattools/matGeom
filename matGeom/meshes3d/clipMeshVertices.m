function [cVertices, cFaces] = clipMeshVertices(vertices, faces, box)
%CLIPMESHVERTICES Clip vertices of a surfacic mesh and remove outer faces
%
%   [V2, F2] = clipMeshVertices(V, F, B)
%   Clip a mesh represented by vertex array V and face array F, with the
%   box represented by B. The result is the set of vertices contained in
%   the box, and a new set of faces corresponding to original faces with
%   all vertices within the box.
%
%   Example
%     [v, f] = createSoccerBall;
%     box = [-.8 2 -.8 2 -.8 2];
%     [v2, f2] = clipMeshVertices(v, f, box);
%     figure; drawMesh(v2, f2, 'faceAlpha', .7); 
%     view(3); axis equal;
%
%   See also
%   meshes3d, clipPoints3d
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-04-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% if input is given as a structure, parse fields
if isstruct(vertices)
    box = faces;
    faces = vertices.faces;
    vertices = vertices.vertices;
end

% clip the vertices
[cVertices, indVertices] = clipPoints3d(vertices, box);


% create index array for face indices relabeling
refInds = zeros(size(indVertices));
for i = 1:length(indVertices)
    refInds(indVertices(i)) = i;
end

% select the faces with all vertices within the box
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
    
    % re-label indices of face vertices (keeping horizontal index array)
    for i = 1:length(cFaces)
        cFaces{i} = refInds(cFaces{i})';
    end
end
