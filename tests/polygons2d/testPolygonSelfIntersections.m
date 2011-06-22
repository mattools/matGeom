function test_suite = testPolygonSelfIntersections(varargin) %#ok<STOUT>
%TESTPOLYGONSELFINTERSECTIONS  One-line description here, please.
%   output = testPolygonSelfIntersections(input)
%
%   Example
%   testPolygonPoint
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-16,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

initTestSuite;


function testSquare %#ok<*DEFNU>

poly = [0 0;10 0;10 10;0 10];
intersects = polygonSelfIntersections(poly);
assertTrue(isempty(intersects));


function testSingleIntersect

% use a 8-shaped polygon.
poly = [10 0;0 0;0 10;20 10;20 20;10 20];
intersects = polygonSelfIntersections(poly);

assertEqual(1, size(intersects, 1));
assertElementsAlmostEqual([10 10], intersects);


function testEllipseArc

t = linspace(-pi/2, pi/2, 60)';
arc = [10+3*cos(t) 20+5*sin(t)];

intersects = polygonSelfIntersections(arc);

assertTrue(isempty(intersects));


function testCrossingAtFirstPoint

poly = [20 20; 30 20;20 30;20 10; 10 20];
intersects = polygonSelfIntersections(poly);

assertEqual(1, size(intersects, 1));

exp = [20 20];
assertElementsAlmostEqual(exp, intersects);

