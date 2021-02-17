function writeMesh_stl(fileName, vertices, faces, varargin)
%WRITEMESH_STL Write mesh data in the STL format.
%
%   writeMesh_stl(FNAME, VERTICES, FACES)
%
%   writeMesh_stl(FNAME, MESH)
%
%   writeMesh_stl(FNAME, VERTICES, FACES, ...) see stlwrite for additonal
%   options
%
%   Example
%   mesh = cylinderMesh([60 50 40 10 20 30 5], 1);
%   writeMesh_stl('Cylinder.stl', mesh, 'bin');
%
%   References
%   Wrapper function for MATLAB's build-in stlwrite.
%
%   See also
%   meshes3d, writeMesh, writeMesh_off, writeMesh_ply

% ------
% Author: oqilipo
% Created: 2021-02-13, using Matlab 9.9.0.1538559 (R2020b)
% Copyright 2021

%% Check inputs
if ~ischar(fileName)
    error('First argument must contain the name of the file');
end

% optionnaly parses data
if isstruct(vertices)
    if nargin > 2
        varargin = [{faces} varargin{:}];
    end
    faces = vertices.faces;
    vertices = vertices.vertices;
end

%% Write STL
TR = triangulation(faces, vertices);
stlwrite(TR,fileName, varargin{:})

end