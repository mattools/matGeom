function vol = tetrahedronVolume(tetra, varargin)
%TETRAHEDRONVOLUME Signed volume of a tetrahedron
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
%     tetrahedronVolume(V, F)
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

% control on inputs
if nargin == 4
    tetra = [tetra ; varargin{1} ; varargin{2} ; varargin{3}];
end

if size(tetra, 1) < 4
    error('Input vertex array requires at least 4 vertices');
end

% compute volume of tetrahedron, using first vertex as origin
vol = det(tetra(2:4,:) - tetra([1 1 1],:)) / 6;
