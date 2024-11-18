function varargout = clipMeshByBox(varargin)
%CLIPMESHBYBOX Clip a mesh by a box.
%
%   [V2, F2] = clipMeshByBox(V, F, BOX)
%   Clip a mesh defined by the vertices V and faces F by a BOX and return
%   the part of the mesh (V2, F2) inside the box. New vertices, edges and 
%   faces are created at the intersections with box.
%
%   [...] = clipMeshByPlane(MESH, BOX)
%   Alternativly, a struct MESH with the fields 'vertices' and 'faces' can
%   be used as input argument.
%
%   MESH2 = clipMeshByPlane(..., BOX)
%   Returns the struct MESH2 with the fields 'vertices' and 'faces'.
%
%   Example
%     box = [-4 7 2 6 -1 8];
%     mesh = readMesh('bunny_F1k.ply');
%     mesh2 = clipMeshByBox(mesh, box);
%     drawBox3d(box)
%     drawMesh(mesh)
%     drawMesh(mesh2,'m')
%     view(105, 30); axis equal
%   
%   See also 
%     clipMeshByPlane, cutMeshByPlane, 

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2024-11-16, using MATLAB 23.2.0.2515942 (R2023b) Update 7
% Copyright 2024

% Parse input
[v, f] = parseMeshData(varargin{1:end-1});
box = varargin{end};

% Create the box planes pointing inwards
boxMesh = boxToMesh(box);
boxMeshNormals = meshFaceNormals(boxMesh)*-1;
boxMeshCentroids = meshFaceCentroids(boxMesh);
boxPlanes = createPlane(boxMeshCentroids, boxMeshNormals);

% Clip the mesh with the six planes of the box
for bp = 1:size(boxPlanes,1) 
    [v, f] = clipMeshByPlane(v, f, boxPlanes(bp,:));
end

% Parse output
varargout = formatMeshOutput(nargout, v, f);
