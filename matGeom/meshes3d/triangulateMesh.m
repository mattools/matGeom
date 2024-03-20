function varargout = triangulateMesh(varargin)
%TRIANGULATEMESH Convert a non-triangle mesh into a triangle mesh.
%
%   [V2, F2] = triangulateMesh(V, F)
%   Convert the mesh represented by vertices V and faces F into a triangle
%   mesh. V is N-by-3 numeric array containing vertex coordinates. F is an
%   array representing faces: either a N-by-4 or N-by-3 numeric array, or a
%   cell array for meshes with non homogeneous face vertex counts.
%   The result is a mesh with same vertices (V == F), and F2 represented as
%   a N-by-3 numeric array. If the input mesh is already a triangular mesh,
%   the result is the same as the input.
%
%   [V2, F2] = triangulateMesh(MESH)
%   Specifies the mesh as a structure with at least two fields 'vertices'
%   and 'faces'. 
%
%   MESH2 = triangulateMesh(...)
%   Returns the result as a mesh data structure with two fields 'vertices'
%   and 'faces'. 
%
%   Example
%     % create a basic shape
%     [v, f] = createCubeOctahedron;
%     % draw with plain faces
%     figure; hold on; axis equal; view(3);
%     drawMesh(v, f);
%     % draw as a triangulation
%     [v2, f2] = triangulateMesh(v, f);
%     figure; hold on; axis equal; view(3);
%     drawMesh(v2, f2, 'facecolor', 'r');
%
%   See also 
%     meshes3d, triangulateFaces, drawMesh
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2024-02-16,    using Matlab 23.2.0.2459199 (R2023b) Update 5
% Copyright 2024 INRAE.

[vertices, faces] = parseMeshData(varargin{:});

faces2 = triangulateFaces(faces);

varargout = formatMeshOutput(nargout, vertices, faces2);
