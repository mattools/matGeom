function alpha = meshDihedralAngles(vertices, edges, faces)
%MESHDIHEDRALANGLES Dihedral at edges of a polyhedal mesh
%
%   ALPHA = meshDihedralAngles(V, E, F)
%   where V, E and F represent vertices, edges and faces of a mesh,
%   computes the dihedral angle between the two adjacent faces of each edge
%   in the mesh. ALPHA is a column array with as many rows as the number of
%   edges. The i-th element of ALPHA corresponds to the i-th edge.
%
%   Note: the function assumes that the faces are correctly oriented. The
%   face vertices should be indexed counter-clockwise when considering the
%   supporting plane of the face, with the outer normal oriented outwards
%   of the mesh.
%
%   Example
%   [v e f] = createCube;
%   rad2deg(meshDihedralAngles(v, e, f))
%   ans = 
%       90
%       90
%       90
%       90
%       90
%       90
%       90
%       90
%       90
%       90
%       90
%       90
%
%   See also
%   meshes3d, polyhedronMeanBreadth, dihedralAngle
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% compute normal of each face
normals = faceNormal(vertices, faces);

% indices of faces adjacent to each edge
edgeFaces = meshEdgeFaces(vertices, edges, faces);

% allocate memory for resulting angles
Ne = size(edges, 1);
alpha = zeros(Ne, 1);

% iterate over edges
for i = 1:Ne
    % indices of adjacent faces
    indFace1 = edgeFaces(i, 1);
    indFace2 = edgeFaces(i, 2);
    
    % normal vector of adjacent faces
    normal1 = normals(indFace1, :);
    normal2 = normals(indFace2, :);
    
    % compute dihedral angle of two vectors
    alpha(i) = vectorAngle3d(normal1, normal2);
end

