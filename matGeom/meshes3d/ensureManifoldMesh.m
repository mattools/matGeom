function varargout = ensureManifoldMesh(varargin)
%ENSUREMANIFOLDMESH Apply several simplification to obtain a manifold mesh
%
%   output = ensureManifoldMesh(input)
%
%   Example
%   ensureManifoldMesh
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-02-01,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2019 INRA - Cepia Software Platform.


%% Parse input arguments

vertices = varargin{1};
faces = varargin{2};

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

switch nargout
    case 1
        mesh.vertices = vertices;
        mesh.faces = faces;
        varargout{1} = mesh;
    case 2
        varargout{1} = vertices;
        varargout{2} = faces;
end

