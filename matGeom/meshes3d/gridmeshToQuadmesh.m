function varargout = gridmeshToQuadmesh(x, y, varargin)
%GRIDMESHTOQUADMESH Create a quad mesh from a grid mesh
%
%   [V F] = gridmeshToQuadmesh(X, Y)
%   [V F] = gridmeshToQuadmesh(X, Y, Z)
%
%   Example
%     [X,Y] = meshgrid(-2:.2:2, -2:.2:2);                                
%     Z = X .* exp(-X.^2 - Y.^2);
%     [V F] = gridmeshToQuadmesh(X, Y, Z);
%     figure;
%     drawMesh(V, F);
%
%   See also
%     meshgrid, drawMesh
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-18,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% number of vertices
dim = size(x);
nv = prod(dim);

% vertex indices in grid
inds = reshape(1:nv, dim);

% create vertices
if isempty(varargin)
    vertices = [x(:) y(:)];
else
    z = varargin{1};
    vertices = [x(:) y(:) z(:)];
end

% create faces
v1 = inds(1:end-1, 1:end-1);
v2 = inds(1:end-1, 2:end);
v3 = inds(2:end, 2:end);
v4 = inds(2:end, 1:end-1);

faces = [v1(:) v2(:) v3(:) v4(:)];

% format output
if nargout <= 1
    % concatenate into one structure
    mesh.vertices = vertices;
    mesh.edges = edges;
    mesh.faces = faces;
    varargout = {mesh};
    
elseif nargout == 2
    % returns as separate arguments
    varargout = {vertices, faces};
    
elseif nargout == 3
    % also return vertex indices
    varargout = {vertices, faces, inds};
    
end
