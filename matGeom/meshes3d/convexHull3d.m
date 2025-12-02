function varargout = convexHull3d(pts, varargin)
%CONVEXHULL3D Compute convex hull of 3D points as a polygonal mesh.
%
%   MESH = convexHull3d(PTS)
%   [V, F] = convexHull3d(PTS)
%   Computes the convex hull of the points given by the N-by-3 array of
%   double PTS, and returns the result as a 3D mesh.
%   The output can be ether a mesh structure with fields 'vertices' and
%   'faces', or two variables containing the vertices and the faces of the
%   mesh. Faces are represented as a Nf-by-3 array of vertex indices.
%
%   ... = convexHull3d(PTS, 'mergeCoplanarFaces', true)
%   Applies an additional processing that transforms coplanar triangular
%   faces into polygonal faces with arbitrary number of vertices. The
%   'faces' data of the resulting mesh is an array of cells.
%
%   Example
%     pts = rand(50, 3);
%     hull = convexHull3d(pts);
%     figure; hold on; axis equal; drawMesh(hull); view(3);
%
%   See also
%     convexHull, mergeCoplanarFaces
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2025-12-01,    using Matlab 25.1.0.2943329 (R2025a)
% Copyright 2025 INRAE.

mergeCoplanarFacesFlag = false;
if length(varargin) > 1
    pname = varargin{1};
    if strcmpi(pname, 'mergeCoplanarFaces')
        mergeCoplanarFacesFlag = varargin{2};
    else
        error(['Unknown option: ' pname]);
    end
end

% compute index of vertices of the triangulated convex hull
inds = convhulln(pts);
[v, f] = trimMesh(pts, inds);

% optionnally merge coplanar facs
if mergeCoplanarFacesFlag
    [v, f] = mergeCoplanarFaces(v, f);
end

% format output
varargout = formatMeshOutput(nargout, v, f);
