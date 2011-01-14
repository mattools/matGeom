function rays2d(varargin)
%RAYS2D  Description of functions operating on planar rays
%
%   A ray is defined by a point (its origin), and a vector (its
%   direction). The different parameters are bundled into a row vector:
%   RAY = [x0 y0 dx dy];
%
%   The ray contains all the points (x,y) such that:
%   x = x0 + t*dx
%   y = y0 + t*dy;
%   for all t>0
%
%   Contrary to a (straight) line, the points located before the origin do
%   not belong to the ray.
%   However, as rays and lines have the same representation, some functions
%   working on lines are also working on rays (like 'transformLine').
%
%   See also:
%   points2d, vectors2d, lines2d
%   createRay, bisector, isPointOnRay
%   clipRay, drawRay
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

help('rays2d');