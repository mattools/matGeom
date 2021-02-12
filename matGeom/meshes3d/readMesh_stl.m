function varargout = readMesh_stl(fileName)
% Read mesh data stored in STL format.
%
%   [V, F] = readMesh_stl(FNAME) is a wrapper function for MATLAB's  
%   build-in stlread.
%
%   Example
%   readMesh_stl
%
%   See also
%   meshes3d, readMesh, readMesh_off, readMesh_ply
 
% ------
% Author: oqilipo
% Created: 2021-02-12, using Matlab 9.9.0.1538559 (R2020b)
% Copyright 2021

TR = stlread(fileName);
v = TR.Points;
f = TR.ConnectivityList;

varargout = formatMeshOutput(nargout, v, f);
end