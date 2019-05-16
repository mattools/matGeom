function centroid = polyhedronCentroid(vertices, faces) %#ok<INUSD>
%POLYHEDRONCENTROID Compute the centroid of a 3D convex polyhedron.
%
%   CENTRO = polyhedronCentroid(V, F)
%   Computes the centroid (center of mass) of the polyhedron defined by
%   vertices V and faces F.
%   The polyhedron is assumed to be convex.
%
%   Example
%     % Creates a polyhedron centered on origin, and add an arbitrary
%     % translation
%     [v, f] = createDodecahedron;
%     v2 = bsxfun(@plus, v, [3 4 5]);
%     % computes the centroid, that should equal the translation vector
%     centroid = polyhedronCentroid(v2, f)
%     centroid =
%         3.0000    4.0000    5.0000
%
%
%   See also
%   meshes3d, meshVolume, meshSurfaceArea, polyhedronMeanBreadth
%

% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2012-04-05,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% 2015.11.13 use delaunayTriangulation instead of delaunayn (strange bug
%       with icosahedron...)

% compute set of elementary tetrahedra
DT = delaunayTriangulation(vertices);
T = DT.ConnectivityList;

% number of tetrahedra
nT  = size(T, 1);

% initialize result
centroid = zeros(1, 3);
vt = 0;

% Compute the centroid and the volume of each tetrahedron
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
