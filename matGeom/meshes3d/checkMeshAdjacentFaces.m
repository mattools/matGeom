function checkMeshAdjacentFaces(vertices, edges, faces)
%CHECKMESHADJACENTFACES Check if adjacent faces of a mesh have similar orientation.
%
%   checkMeshAdjacentFaces(VERTICES, EDGES, FACES)
%   The functions returns no output, but if two faces share a common edge
%   with the same direction (meaning that adjacent faces have normals in
%   opposite direction), a warning is displayed. 
%   
%   Example
%   [v e f] = createCube();
%   checkMeshAdjacentFaces(v, e, f);
%   % no output -> all faces have normal outwards of the cube
%
%   v = [0 0 0; 10 0 0; 0 10 0; 10 10 0];
%   e = [1 2;1 3;2 3;2 4;3 4];
%   f = [1 2 3; 2 3 4];
%   checkMeshAdjacentFaces(v, e, f);
%      Warning: Faces 1 and 2 run through the edge 3 (2-3) in the same direction
%
%   See also
%     meshes3d, trimeshMeanBreadth
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-10-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% the message pattern that is displayed when an inconsistency is encountered
pattern = 'Faces %d and %d run through the edge %d (%d-%d) in the same direction';

% If edges are not specified, compute them
if nargin == 2
    faces = edges;
    edges = meshEdges(vertices, faces);
end

% compute edges to faces map
edgeFaces = meshEdgeFaces(vertices, edges, faces);
Ne = size(edgeFaces, 1);

for i = 1:Ne
    % indices of extreimty vertices
    v1 = edges(i, 1);
    v2 = edges(i, 2);
    
    % index of adjacent faces
    indF1 = edgeFaces(i, 1);
    indF2 = edgeFaces(i, 2);
    
    % if one of the faces has index 0, then the edge is at the boundary
    if indF1 == 0 || indF2 == 0
        continue;
    end
    % vertices of adjacent faces
    face1 = meshFace(faces, indF1);
    face2 = meshFace(faces, indF2);
    
    % position of vertices in face vertex array
    ind11 = find(face1 == v1);
    ind12 = find(face1 == v2);
    ind21 = find(face2 == v1);
    ind22 = find(face2 == v2);
    
    % check if edge is traveled forward or backard
    direct1 = (ind12 == ind11+1) | (ind12 == 1 & ind11 == length(face1));
    direct2 = (ind22 == ind21+1) | (ind22 == 1 & ind21 == length(face2));
    
    % adjacent faces should travel the edge in opposite direction
    if direct1 == direct2
        warning(pattern, indF1, indF2, i, v1, v2); %#ok<WNTAG>
    end
end
