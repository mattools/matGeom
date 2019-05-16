function nFaces = meshFaceNumber(varargin)
%MESHFACENUMBER Returns the number of faces in this mesh.
%
%   NF = meshFaceNumber(V, F)
%   NF = meshFaceNumber(V, E, F)
%   NF = meshFaceNumber(MESH)
%   Returns the number of faces in the given mesh. As the face array may be
%   represented either as numeric array or as cell array of indices, this
%   function is a convenient way to get the number of faces independanlty
%   of the mesh representation.
%
%   Example
%     [v f] = createCube;
%     meshFaceNumber(v, f)
%     ans =
%         6
%
%   See also
%     meshes3d
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-08-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

[vertices, faces] = parseMeshData(varargin{:}); %#ok<ASGLU>

if iscell(faces)
    nFaces = length(faces);
else
    nFaces = size(faces, 1);
end
