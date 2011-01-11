function circles2d(varargin)
%CIRCLES2D Description of functions operating on circles
%
%   Circles are represented by their center and their radius:
%   C = [xc yc r];
%   One sometimes considers orientation of circle, by adding an extra
%   boolean value in 4-th position, with value TRUE for direct (i.e.
%   turning Counter-clockwise) circles.
%
%   Circle arcs are represented by their center, their radius, the starting
%   angle and the angle extent.
%   CA = [xc yc r theta0 dtheta];
%   
%   Ellipses are represented by their center, their 2 semi-axis length, and
%   their angle with Ox direction.
%   E = [xc yc A B theta];
%
%
%   See also:
%   createCircle, createDirectedCircle, enclosingCircle
%   isPointInCircle, isPointOnCircle, radicalAxis
%   circleAsPolygon, circleArcAsCurve, ellipseAsPolygon
%   drawCircle, drawCircleArc, drawEllipse, drawEllipseArc
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2010 INRA - Cepia Software Platform.

help('circles2d');