function varargout = drawFaceNormals(varargin)
%DRAWFACENORMALS Draw normal vector of each face in a mesh.
%
%   drawFaceNormals(V, E, F)
%   Compute and draw the face normals of the mesh defined by vertices V,
%   edges E and faces F. See meshes3d for format of each argument.
%
%   H = drawFaceNormals(...)
%   Return handle array to the created objects.
%
%   Example
%   % draw face normals of a cube
%     [v, f] = createCubeOctahedron;
%     figure; drawMesh(v, f)
%     axis([-2 2 -2 2 -2 2]); axis equal; hold on;
%     drawFaceNormals(v, f)
%     view(3);
%
%   See also
%   meshes3d, drawMesh, drawVector3d, meshFaceNormals, meshFaceCentroids
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-10-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% extract vertices and faces
mesh = parseMeshData(varargin{:});

% compute vector data
c = meshFaceCentroids(mesh);
n = meshFaceNormals(mesh);

% display an arrow for each normal
h = quiver3(c(:,1), c(:,2), c(:,3), n(:,1), n(:,2), n(:,3));

% format output
if nargout > 0
    varargout{1} = h;
end
