function varargout = ensureManifoldMesh(varargin)
%ENSUREMANIFOLDMESH Apply several simplification to obtain a manifold mesh.
%
%   Try to transform an input mesh into a manifold mesh.
%
%   Not all cases of "non-manifoldity" are checked, so please use with
%   care.
%
%   [V2, F2] = ensureManifoldMesh(V, F);
%   [V2, F2] = ensureManifoldMesh(MESH);
%   MESH2 = ensureManifoldMesh(...);
%
%   Example
%   ensureManifoldMesh
%
%   See also
%    meshes3d, isManifoldMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-02-01,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2019 INRA - Cepia Software Platform.


%% Parse input arguments

[vertices, faces] = parseMeshData(varargin{:});
verbose = true;


%% Pre-processing

% remove duplicate faces if any
if verbose
    disp('remove duplicate faces');
end
faces = removeDuplicateFaces(faces);


%% Iterative processing of multiple edges
% Reduces all edges connected to more than two faces, by collapsing second
% vertex onto the first one.

% iter = 0;
% while ~isManifoldMesh(vertices, faces) && iter < 10
%     iter = iter + 1;
    if verbose
        disp('collapse edges with many faces');
    end
    
    [vertices, faces] = collapseEdgesWithManyFaces(vertices, faces);
% end



%% Format output

varargout = formatMeshOutput(nargout, vertices, faces);

