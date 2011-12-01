function tri = triangulatePolygon(poly)
%TRIANGULATEPOLYGON Compute a triangulation of the polygon
%
%   TRI = triangulatePolygon(POLY)
%   Computes a triangulation TRI of the polygon defined by POLY
%   POLY contains the polygon vertices, as a Nv-by-2 array of double. 
%   TRI is a Nt-by-3 array containing indices of vertices forming the
%   triangles. 
%
%   Example
%     % creates a simple polygon and computes its Delaunay triangulation
%     poly = [0 0 ; 10 0;5 10;15 15;5 20;-5 10];
%     figure;drawPolygon(poly); axis equal
%     tri = triangulatePolygon(poly);
%     figure;
%     %patch('Faces', tri, 'Vertices', poly, 'facecolor', 'c');
%     drawMesh(poly, tri, 'facecolor', 'c');
%     axis equal
%
%     % Another example for which constrains were necessary
%     poly2 = [10 10;80 10; 140 20;30 20; 80 30; 140 30; 120 40;10 40];
%     tri2 = triangulatePolygon(poly2);
%     figure; drawMesh(poly2, tri2);
%     hold on, drawPolygon(poly2, 'linewidth', 2);
%     axis equal
%     axis([0 150 0 50])
%
%   See also
%     DelaunayTri, drawMesh, patch
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-11-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% compute constraints
nv = size(poly, 1);
cons = [(1:nv)' [2:nv 1]'];

% delaunay triangulation 
dt = DelaunayTri(poly(:,1), poly(:, 2), cons);

% find which triangles are contained in polygon
centers = incenters(dt);
inds = isPointInPolygon(centers, poly);

% keep selected triangles
tri = dt.Triangulation(inds, :);
