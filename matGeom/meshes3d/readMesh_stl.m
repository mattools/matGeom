function varargout = readMesh_stl(fileName)
%READMESH_STL Read mesh data stored in STL format.
%
%   [VERTICES, FACES] = readMesh_stl(FNAME)
%
%   MESH = readMesh_stl(FNAME)
%
%   Example
%   readMesh_stl
%
%   References
%   Wrapper function for MATLAB's build-in stlread.
%
%   See also
%   meshes3d, readMesh, readMesh_off, readMesh_ply

% ------
% Author: oqilipo
% Created: 2021-02-12, using Matlab 9.9.0.1538559 (R2020b)
% Copyright 2021

TR = stlread(fileName);
vertices = TR.Points;
faces = TR.ConnectivityList;

varargout = formatMeshOutput(nargout, vertices, faces);

end