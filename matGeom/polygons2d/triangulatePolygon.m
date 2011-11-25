function tri = triangulatePolygon(poly)
%TRIANGULATEPOLYGON Compute a triangulation of the polygon
%
%   TRI = triangulatePolygon(POLY)
%   POLY contains the polygon vertices. TRI is a Nt-by-3 array containing
%   indices of vertices forming the triangles.
%
%   Example
%     % creates a simple polygon and computes its Delaunay triangulation
%     poly = [0 0 ; 10 0;5 10;15 15;5 20;-5 10];
%     figure;drawPolygon(poly); axis equal
%     tri = triangulatePolygon(poly);
%     figure;
%     doc patch
%     help patch
%     patch('Faces', tri, 'Vertices', poly, 'facecolor', 'c');
%     axis equal
%
%   See also
%     patch
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-11-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% delaunay triangulation 
dt = DelaunayTri(poly(:,1), poly(:, 2));

% find which triangles are contained in polygon
centers = incenters(dt);
inds = isPointInPolygon(centers, poly);

% keep selected triangles
tri = dt.Triangulation(inds, :);
