function centroid = polyhedronCentroid(vertices, faces) %#ok<INUSD>
%POLYHEDRONCENTROID Compute the centroid of a 3D convex polyhedron
%
%   CENTRO = polyhedronCentroid(V, F)
%   Computes the centroid (center of mass) of the polyhedron defined by
%   vertices V and faces F.
%   The polyhedron is assumed to be convex.
%
%   Example
%   polyhedronCentroid
%
%   See also
%   meshes3d, tetrahedronVolume
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-04-05,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% compute set of elementary tetrahedra
T = delaunayn(vertices);

% number of tetrahedra
nT  = size(T, 1);

% initialize result
centroid = zeros(1, 3);

% Compute the centroid and the volum of each tetraehdron
for i = 1:nT
    % coordinates of tetrahedron vertices
    tetra = vertices(T(i, :), :);
    
    % centroid is the average of vertices. 
    centi = mean(tetra);
    
    % compute volume of tetrahedron
    vol = det(tetra(1:3,:) - tetra([4 4 4],:)) / 6;
    
    % add weighted centroid of current tetraedron
    centroid = centroid + centi * vol;
    
    % compute the sum of tetraedra volumes
    vt = vt + vol;
end

% compute by sum of tetrahedron volumes
centroid = centroid / vt;
