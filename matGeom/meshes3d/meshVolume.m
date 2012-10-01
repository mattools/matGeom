function vol = meshVolume(vertices, edges, faces)
%MESHVOLUME Volume of the space enclosed by a polygonal mesh
%
%   output = meshVolume(input)
%
%   Example
%     % computes the volume of a unit cube (should be equal to 1...)
%     [v f] = createCube;
%     meshVolume(v, f)
%     ans = 
%         1
%
%   See also
%   meshes3d, meshSurfaceArea, tetrahedronVolume
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% check input number
if nargin == 2
    faces = edges;
end

faces = triangulateFaces(faces);

nFaces = size(faces, 1);
vols = zeros(nFaces, 1);

% a 3x3 matrix representing repetition of centroid
centroid = repmat(mean(vertices), 3, 1);

% compute volume of each tetraedron
for i = 1:nFaces
    % consider the tetrahedron formed by face and mesh centroid
    face = faces(i, :);
    tetra = vertices(face, :) - centroid;
    
    % volume of current tetrahedron
    vols(i) = det(tetra) / 6;
end

vol = sum(vols);
