function varargout = gridmeshToQuadmesh(x, y, varargin)
%GRIDMESHTOQUADMESH Create a quad mesh from a grid mesh
%
%   Deprecated: replaced by surfToMesh (2012.10.25)
%
%   [V F] = gridmeshToQuadmesh(X, Y)
%   [V F] = gridmeshToQuadmesh(X, Y, Z)
%   Converts the surface grid given by two or three coordinate arrays into
%   a face-vertex quad mesh.
%
%   Example
%     % transform a surface into a mesh
%     [X,Y] = meshgrid(-2:.2:2, -2:.2:2);                                
%     Z = X .* exp(-X.^2 - Y.^2);
%     [V F] = gridmeshToQuadmesh(X, Y, Z);
%     figure;
%     drawMesh(V, F);
%
%     % Transform surface of a cylinder as a mesh
%     [x y z] = cylinder(5*ones(1, 10));
%     [v f] = gridmeshToQuadmesh(x, y, z);
%     figure;
%     drawMesh(v, f);
%     view(3); axis equal;
%
%   See also
%     meshes3d, meshgrid, drawMesh
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-18,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

warning('MatGeom:deprecated', ...
    'function "gridmeshToQuadmesh" is deprecated, and was replaced by "surfToMesh".');

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
