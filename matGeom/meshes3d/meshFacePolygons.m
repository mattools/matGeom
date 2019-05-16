function polys = meshFacePolygons(varargin)
%MESHFACEPOLYGONS Returns the set of polygons that constitutes a mesh.
%
%   POLYGONS = meshFacePolygons(V, F)
%   POLYGONS = meshFacePolygons(MESH)
%
%   Example
%     [v f] = createCubeOctahedron;
%     polygons = meshFacePolygons(v, f);
%     areas = polygonArea3d(polygons);
%     sum(areas)
%     ans =
%         18.9282
%
%   See also
%     meshes3d, meshFace, polygonArea3d

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-08-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

% extract vertices and faces
[v, f] = parseMeshData(varargin{:});

% number of faces
if iscell(f)
    nFaces = length(f);
else
    nFaces = size(f, 1);
end

% allocate cell array for result
polys = cell(nFaces, 1);

% compute polygon corresponding to each face
if iscell(f)
    for i = 1:nFaces
        polys{i} = v(f{i}, :);
    end
else
    for i = 1:nFaces
        polys{i} = v(f(i,:), :);
    end
end