function face = meshFace(faces, index)
%MESHFACE Return the vertex indices of a face in a mesh.
%
%   FACE = meshFace(FACES, INDEX)
%   Return the vertex indices of the i-th face in the face array. This is
%   mainly an utility function that manages faces stored either as int
%   array (when all faces have same number of sides) or cell array (when
%   faces may have different number of edges).
%
%   Example
%     [v, f] = createCubeOctahedron;
%     % some faces are squares
%     meshFace(f, 1)
%     ans =
%          1     2     3     4
%     % other are triangles
%     meshFace(f, 2)
%     ans =
%          1     5     2
%
%   See also
%     meshes3d, meshFaceCentroid, meshFaceNormals, meshFaceAreas

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-10-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


% process mesh given as structure
if isstruct(faces)
    if isfield(faces, 'faces')
        faces = faces.faces;
    else
        error('Mesh structure should contains a field ''faces''');
    end
end

% switch between numeric or cell array
if isnumeric(faces)
    face = faces(index, :);
else
    face = faces{index};
end

