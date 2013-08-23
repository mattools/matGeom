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

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% HISTORY
% 2013-08-16 speed improvement by Sven Holcombe

% check input number
if nargin == 2
    faces = edges;
end

% ensure mesh has triangle faces
faces = triangulateFaces(faces);

% initialize an array of volume
nFaces = size(faces, 1);
vols = zeros(nFaces, 1);

% Shift all vertices to the mesh centroid
vertices = bsxfun(@minus, vertices, mean(vertices,1));

% compute volume of each tetraedron
for i = 1:nFaces
    % consider the tetrahedron formed by face and mesh centroid
    tetra = vertices(faces(i, :), :);
    
    % volume of current tetrahedron
    vols(i) = det(tetra) / 6;
end

vol = sum(vols);
