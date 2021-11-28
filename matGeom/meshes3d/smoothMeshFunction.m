function f = smoothMeshFunction(vertices, faces, f, varargin) %#ok<INUSL>
% Apply smoothing on a functions defines on mesh vertices.
%
%   FS = smoothMeshFunction(VERTICES, FACES, F, NITERS)
%   Performs smoothing on the function F defined on vertices of the mesh.
%   The mesh is specified by VERTICES and FACES array. At each iteration,
%   the value for each vertex is obtained as the average of values obtained
%   from neighbor vertices.
%   NITERS is the number of times the iteration must be repeated. By
%   default it equals 3.
%
%   Example
%   smoothMeshFunction
%
%   See also
%     meshes3d, meshCurvatures
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2021-09-22,    using Matlab 9.10.0.1684407 (R2021a) Update 3
% Copyright 2021 INRAE.

% determines number of iterations
nIters = 3;
if ~isempty(varargin)
    nIters = varargin{1};
end
    
% apply smoothing on scalar function
nv = max(faces(:));

% compute normalized averaging matrix
W = meshAdjacencyMatrix(faces) + speye(nv);
D = spdiags(full(sum(W,2).^(-1)), 0, nv, nv);
W = D * W;

% do averaging to smooth the field
for j = 1:size(f, 2)
    for k = 1:nIters
        f(:,j) = W * f(:,j);
    end
end
