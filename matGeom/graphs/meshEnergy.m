function energy = meshEnergy(vertices, faces)
%MESHENERGY  One-line description here, please.
%
%   output = meshEnergy(input)
%
%   Example
%   meshEnergy
%
%   See also
%
 
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
