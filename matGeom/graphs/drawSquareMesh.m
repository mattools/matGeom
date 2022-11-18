function varargout = drawSquareMesh(nodes, edges, faces, varargin) %#ok<INUSL>
%DRAWSQUAREMESH Draw a 3D square mesh given as a graph.
%
%   drawSquareMesh(NODES, EDGES, FACES)
%   Draw the mesh defined by NODES, EDGES and FACES. FACES must be a N-by-4
%   array of vertex indices.
%
%   See Also
%   boundaryGraph, drawGraph

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-06-28
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

% input size check up
if size(faces, 2) ~= 4
    error('Requires a face array with 4 columns');
end

% number of faces
Nf = size(faces, 1);

% allocate memory for vertex coordinates
px = zeros(4, Nf);
py = zeros(4, Nf);
pz = zeros(4, Nf);

% initialize vertex coordinates of each face
for f = 1:Nf
    face = faces(f, 1:4);
    px(1:4, f) = nodes(face, 1);
    py(1:4, f) = nodes(face, 2);
    pz(1:4, f) = nodes(face, 3);
end

p = patch(px, py, pz, 'r');

if nargout > 0
    varargout = {p};
end
