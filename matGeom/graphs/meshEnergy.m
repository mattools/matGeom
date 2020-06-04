function energy = meshEnergy(vertices, faces)
% Computes the energy of a tesselation, as the sum of second area moments.
%
%   This function can be used to check that the total energy of Centroidal
%   Voronoi Tesselation (CVT) decreases with the iterations of the Lloyd
%   algorithm.
%
%   E = meshEnergy(V, F)
%   V is the list of mesh vertices, and F are faces, as a cell array of
%   vertex indices.
%
%   Example
%   meshEnergy
%
%   See also
%     centroidalVoronoi2d, cvtUpdate, polygonSecondAreaMoments
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-09-01,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.

nFaces = meshFaceNumber(vertices, faces);

energyList = zeros(nFaces, 1);

polygons = meshFacePolygons(vertices, faces);
for i = 1:nFaces
    [Ix, Iy, Ixy] = polygonSecondAreaMoments(polygons{i}); %#ok<ASGLU>
    energyList(i) = hypot(Ix, Iy);
end

energy = sum(energyList);
