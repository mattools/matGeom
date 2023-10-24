function [nodes2, faces2] = clipConvexPolyhedronHP(nodes, faces, plane)
%CLIPCONVEXPOLYHEDRONHP Clip a convex polyhedron by a plane.
%
%   [NODES2, FACES2] = clipConvexPolyhedronHP(NODES, FACES, PLANE)
%
%   return the new (convex) polyhedron whose vertices are 'below' the
%   specified plane, and with faces clipped accordingly. NODES2 contains
%   clipped vertices and new created vertices, FACES2 contains references
%   to NODES2 vertices.
%
%   Example
%     [N, F] = createCube;
%     P = createPlane([.5 .5 .5], [1 1 1]);
%     [N2, F2] = clipConvexPolyhedronHP(N, F, P);
%     figure('color','w'); view(3); axis equal
%     drawPolyhedron(N2, F2);
% 
%     [v, f] = createSoccerBall;
%     p = createPlane([-.5 .5 -.5], [1 1 1]);
%     [v2, f2] = clipConvexPolyhedronHP(v, f, p);
%     figure('color','w'); view(3); axis equal
%     drawMesh(v, f, 'faceColor', 'none');
%     drawMesh(v2, f2);
%
%   See also 
%     meshes3d, polyhedra, planes3d
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2007-09-14, using Matlab 7.4.0.287 (R2007a)
% Copyright 2007-2023 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas

warning('matGeom:deprecated', ...
    'This function is deprecated, use ''clipConvexPolyhedronByPlane'' instead');

[nodes2, faces2] = clipConvexPolyhedronByPlane(nodes, faces, plane);
