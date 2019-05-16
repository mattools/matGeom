function varargout = createStellatedMesh(vertices, faces, varargin)
%CREATESTELLATEDMESH  Replaces each face of a mesh by a pyramid.
%
%   [V2, F2] = createStellatedMesh(V, F)
%
%   Example
%     [v, f] = createCube
%     [v2, f2] = createStellatedMesh(v, f);
%     figure; drawMesh(v2, f2); axis equal; view(3);
%
%   See also
%     meshes3d, drawMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-11-27,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2018 INRA - Cepia Software Platform.

% properties of mesh
nVertices = size(vertices, 1);
nFaces = size(faces, 1);

% shift coefficients for computing new vertices
coeffs = ones(nFaces, 1);
if ~isempty(varargin)
    var1 = varargin{1};
    if isnumeric(var1) && isscalar(var1)
        coeffs = coeffs * var1;
    elseif isnumeric(var1) && length(var1) == nFaces
        coeffs = var1(:);
    else
        error('Coefficients must be either a scalar or a nFaces-by-1 array');
    end
end

% supporting line of new vertices
fc = meshFaceCentroids(vertices, faces);
fn = meshFaceNormals(vertices, faces);

% position of new vertices
nv = fc + bsxfun(@times, fn, coeffs);

% create data for new mesh
v2 = [vertices ; nv];
f2 = zeros(nFaces * 3, 3);
indF = 0;

% iterate over faces
for iFace = 1:nFaces
    % indices of vertices of current face
    face = meshFace(faces, iFace);
%     face = faces(iFace, :);

    % iterate over edges to create new triangular faces
    for ivf = 1:length(face)
        ind1 = face(ivf);
        ind2 = face(mod(ivf, length(face)) + 1);
        
        indF = indF + 1;
        f2(indF, :) = [ind1 ind2 iFace+nVertices];
    end
end

% format output
varargout = formatMeshOutput(nargout, v2, f2);
