function meshes3d(varargin)
%MESHES3D  Description of functions operating on 3D meshes
%   
%   Meshes are represented using the classical VF or 'Vertex-Faces'
%   structure. Each mesh is composed of two variables V and F:
%   - V being a set of vertices, represented by a Nv-by-3 array
%   - F being a set of faces, represented either by a Nf-by-3, a Nf-by-4
%   array, or by a Nf-by-1 array of cells, each cell or each row containing
%   indices of vertices for a given face.
%
%   The library provides function to create basic polyhedric meshes (the 5
%   platonic solids, plus few others), as well as functions to perform
%   basic computations (normal angles, face centroids...).
%   The 'MengerSponge' structure is an example of mesh that is not simply
%   connected (multiple tunnels in the structure).
%
%   The drawMesh function is mainly a wrapper to the Matlab 'patch'
%   function, allowing passing arguments more quickly.
%
%   Example
%   % create a soccer ball mesh and display it
%   [n e f] = createSoccerBall;
%   drawMesh(n, f, 'faceColor', 'g', 'linewidth', 2);
%   axis equal;
%
%   drawMesh - for drawing
%   minConvexHull - for computing something drawMesh
%
%   See also
%   faceCentroids, faceNormal, polyhedronNormalAngle, meshDihedralAngles
%   meshEdgeFaces, meshEdgeLength, polyhedronMeanBreadth
%   polyhedra, minConvexHull, triangulateFaces, meshReduce
%   drawMesh
%   
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% HISTORY 
% 2010-07-27 rename as meshes3d