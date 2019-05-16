function vol = tetrahedronVolume(vertices, varargin)
%TETRAHEDRONVOLUME Signed volume of a tetrahedron.
%
%   VOL = tetrahedronVolume(TETRA)
%   Comptues the siged volume of the tetrahedron TETRA defined by a 4-by-4
%   array representing the polyhedron vertices.
%
%   Example
%     vi = [0 0 0;1 0 0;0 1 0;0 0 1];
%     tetrahedronVolume(vi)
%     ans = 
%         0.1667
%
%     [V F] = createTetrahedron;
%     tetrahedronVolume(V)
%     ans = 
%         -.3333
%
%   See also
%   meshes3d, createTetrahedron, meshVolume
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-04-05,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

if nargin == 2
    tetras = varargin{1};
    nTetras = size(tetras, 1);
    vol = zeros(nTetras, 1);
    for i = 1:nTetras
        tetra = tetras(i,:);
        vol(i) = det(bsxfun(@minus, vertices(tetra(2:4),:), vertices(tetra(1),:))) / 6;
    end
    return;
end

% control on inputs
if nargin == 4
    vertices = [vertices ; varargin{1} ; varargin{2} ; varargin{3}];
end

if size(vertices, 1) < 4
    error('Input vertex array requires at least 4 vertices');
end

% compute volume of tetrahedron, using first vertex as origin
vol = det(vertices(2:4,:) - vertices([1 1 1],:)) / 6;
