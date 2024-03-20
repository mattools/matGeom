function varargout = transformMesh(varargin)
%TRANSFORMMESH Applies a 3D affine transform to a mesh.
%
%   MESH2 = transformMesh(MESH1, TRANSFO)
%   MESH2 = transformMesh(VERTICES, FACES, TRANSFO)
%   [V2, F2] = transformMesh(...)
%
%   Example
%     mesh1 = createOctahedron;
%     transfo = eulerAnglesToRotation3d([30 20 10]);
%     mesh2 = transformMesh(mesh1, transfo);
%     figure; axis equal; hold on; drawMesh(mesh2, 'faceColor', 'g'); view(3);
%
%   See also 
%     meshes3d, transformPoint3d, drawMesh
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2019-08-08, using Matlab 9.6.0.1072779 (R2019a)
% Copyright 2019-2023 INRA - Cepia Software Platform

% parses input arguments
[vertices, edges, faces] = parseMeshData(varargin{1:end-1});
transfo = varargin{end};

vertices2 = transformPoint3d(vertices, transfo);

% format output
varargout = formatMeshOutput(nargout, vertices2, edges, faces);
