function tri = triangulateFaces(faces)
%TRIANGULATEFACES Convert face array to an array of triangular faces 
%
%   TRI = triangulateFaces(FACES)
%   Returns a 3-columns array of indices, based on the data stored in the
%   argument FACES:
%   - if FACES is a N-by-3 array, returns the same array
%   - if FACES is a N-by-4 array, returns an array with 2*N rows and 3
%       columns, splitting each square into 2 triangles (uses first and
%       third vertex of each square as diagonal).
%   - if FACES is a cell array, split each face into a set of triangles,
%       and returns the union of all triangles. Faces are supposed to be
%       convex.
%
%   Example
%   % create a basic shape
%   [n e f] = createCubeOctahedron;
%   % draw with plain faces
%   figure;
%   drawMesh(n, f);
%   % draw as a triangulation
%   tri = triangulateFaces(f);
%   figure;
%   patch('vertices', n, 'faces', tri, 'facecolor', 'r');
%
%   See also
%   meshes3d, drawMesh
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-09-08,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% avoid to triagulate a triangulation
if isnumeric(faces) && size(faces, 2)==3
    tri = faces;
    return;
end

% for square faces, divide each square into 2 triangles
if isnumeric(faces) && size(faces, 2)==4
    nf = size(faces, 1);
    tri = zeros(nf*2, 3);
    tri(1:2:end, :) = faces(:, [1 2 3]);
    tri(2:2:end, :) = faces(:, [1 3 4]);
    return;
end

% number of faces
nf  = length(faces);

% compute total number of triangles
ni = zeros(nf, 1);
for i=1:nf
    % as many triangles as the number of vertices minus 1
    ni(i) = length(faces{i})-2;
end
nt = sum(ni);

% allocate memory for triangle array
tri = zeros(nt, 3);

% convert faces to triangles
t = 1;
for i=1:nf
    face = faces{i};
    nv = length(face);
    v0 = face(1);
    for j=3:nv
        tri(t, :) = [v0 face(j-1) face(j)];
        t = t+1;
    end
end



