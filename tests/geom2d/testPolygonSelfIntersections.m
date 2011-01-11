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
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;


function testSquare %#ok<*DEFNU>

poly = [0 0;10 0;10 10;0 10];
intersects = polygonSelfIntersections(poly);
assertTrue(isempty(intersects));


function testSingleIntersect

poly = [10 0;0 0;0 10;20 10;20 20;10 20];
intersects = polygonSelfIntersections(poly);
assertElementsAlmostEqual([10 10], intersects);
