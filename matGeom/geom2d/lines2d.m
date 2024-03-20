function lines2d(varargin)
%LINES2D  Description of functions operating on planar lines.
%
%   The term 'line' refers to a planar straight line, which is an unbounded
%   curve. Line segments defined between 2 points, which are bounded, are
%   called 'edge', and are presented in file 'edges2d'.
%
%   A straight line is defined by a point (its origin), and a vector (its
%   direction). The parameters are bundled into a 1-by-4 row vector:
%   LINE = [x0 y0 dx dy];
%
%   A line contains all points (x,y) such that:
%       x = x0 + t*dx
%       y = y0 + t*dy;
%   for all t between -infinity and +infinity.
%
%   See also 
%   points2d, vectors2d, edges2d, rays2d
%   createLine, cartesianLine, medianLine, edgeToLine, lineToEdge
%   orthogonalLine, parallelLine, bisector, radicalAxis, fitLine
%   lineAngle, linePosition, projPointOnLine
%   isPointOnLine, distancePointLine, isLeftOriented
%   intersectLines, intersectLineEdge, clipLine
%   reverseLine, transformLine, drawLine

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2008-10-13, using Matlab 7.4.0.287 (R2007a)
% Copyright 2008-2023 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas

help('lines2d');
