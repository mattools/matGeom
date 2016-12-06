function varargout = boxToMesh(varargin)
% BOXTOMESH Convert a box into a quad mesh with the same size
%
%   [V E F] = boxToMesh(BOX) 
%   Create a box as a polyhedra representation. The box is defined by its  
%   coordinate extents: BOX = [XMIN XMAX YMIN YMAX ZMIN ZMAX] 
%   The result has the form [V E F], where V is a 8-by-3 array with vertex
%   coordinates, E is a 12-by-2 array containing indices of neighbour
%   vertices, and F is a 6-by-4 array containing vertices array of each
%   face.
%
%   [V F] = boxToMesh(BOX)
%   Returns only the vertices and the face vertex indices.
%
%   MESH = boxToMesh(BOX)
%   Returns the data as a mesh structure, with fields 'vertices', 'edges'
%   and 'faces'.
%   
%   ... = boxToMesh()
%   Creates a unit cube
%
%   Example
%   [v, f] = boxToMesh([-2 -1 0 pi 2 3])
%   drawMesh(v, f);
%   
%   See also
%   meshes3d, drawMesh, triangulateFaces

%   ---------
%   authors: David Legland, oqilipo
%   created the 22/09/2016.

p = inputParser;
boxDefault = [0 1 0 1 0 1];
boxDatatype = {'numeric'};
boxAttribs = {'nonempty','vector','numel',6,'real','finite'};
addOptional(p,'box',boxDefault,@(x)validateattributes(x,boxDatatype,boxAttribs))
parse(p,varargin{:})

xmin = p.Results.box(1);
xmax = p.Results.box(2);
ymin = p.Results.box(3);
ymax = p.Results.box(4);
zmin = p.Results.box(5);
zmax = p.Results.box(6);

vertices = [...
    xmin, ymin, zmin; ...
    xmax, ymin, zmin; ...
    xmin, ymax, zmin; ...
    xmax, ymax, zmin; ...
    xmin, ymin, zmax; ...
    xmax, ymin, zmax; ...
    xmin, ymax, zmax; ...
    xmax, ymax, zmax; ...
    ];

edges = [1 2;1 3;1 5;2 4;2 6;3 4;3 7;4 8;5 6;5 7;6 8;7 8];

% faces are oriented such that normals point outwards
faces = [1 3 4 2;5 6 8 7;2 4 8 6;1 5 7 3;1 2 6 5;3 7 8 4];

% format output
varargout = formatMeshOutput(nargout, vertices, edges, faces);