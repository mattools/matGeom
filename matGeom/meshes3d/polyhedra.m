function polyhedra(varargin)
%POLYHEDRA Index of classical polyhedral meshes
%   
%   Polyhedra are specific meshes, with additional assumptions:
%   * the set of faces is assumed to enclose a single 3D domain
%   * each face has a neighbor face for each edge
%   * some functions also assume that normals of all faces point ouwards 
%
%   Example
%   % create a soccer ball mesh and display it
%   [n e f] = createSoccerBall;
%   drawMesh(n, f, 'faceColor', 'g', 'linewidth', 2);
%   axis equal;
%
%   See also
%   meshes3d
%   createCube, createCubeOctahedron, createIcosahedron, createOctahedron
%   createRhombododecahedron, createTetrahedron, createTetrakaidecahedron
%   createDodecahedron, createSoccerBall, createMengerSponge
%   steinerPolytope
%   polyhedronNormalAngle, polyhedronMeanBreadth, minConvexHull
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% HISTORY 
