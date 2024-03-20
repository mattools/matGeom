function edges2d(varargin)
%EDGES2D  Description of functions operating on planar edges.
%
%   An edge is represented by the coordinate of its extremities:
%   EDGE = [X1 Y1 X2 Y2];
%
%   Centered edges are sometimes used (for example for representing main
%   axes of an ellipse or an oriented box). Centered edges are represented
%   by their center, their length, and their orientation (counted in
%   degrees and counter-clockwise).
%   CEDGE = [XC YC LEN THETA];
%
%   A set of edges is represented by a N-by-4 array, each row representing
%   an edge.
%
%
%   See also 
%   lines2d, rays2d, points2d, createEdge, parallelEdge, 
%   edgeAngle, edgeLength, midPoint, edgeToLine, lineToEdge
%   intersectEdges, intersectLineEdge, isPointOnEdge, edgeToPolyline
%   clipEdge, transformEdge, intersectEdgePolygon, centeredEdgeToEdge
%   drawEdge, drawCenteredEdge
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2008-10-13, using Matlab 7.4.0.287 (R2007a)
% Copyright 2008-2023 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas

help('edges2d');
