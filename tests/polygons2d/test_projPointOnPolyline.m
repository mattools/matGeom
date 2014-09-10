function test_suite = test_projPointOnPolyline(varargin) %#ok<STOUT>
%TEST_PROJPOINTONPOLYLINE  One-line description here, please.
%   output = test_projPointOnPolyline(input)
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

p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
poly = [p1;p2;p3;p4];

assertElementsAlmostEqual(  0, projPointOnPolyline([ 0  0], poly));
assertElementsAlmostEqual( .5, projPointOnPolyline([15  0], poly));
assertElementsAlmostEqual(  1, projPointOnPolyline([30  0], poly));
assertElementsAlmostEqual(1.5, projPointOnPolyline([30 15], poly));
assertElementsAlmostEqual(  2, projPointOnPolyline([30 30], poly));
assertElementsAlmostEqual(2.5, projPointOnPolyline([15 30], poly));
assertElementsAlmostEqual(  3, projPointOnPolyline([ 0 30], poly));

assertElementsAlmostEqual(  0, projPointOnPolyline([ 0 12], poly));
assertElementsAlmostEqual(  3, projPointOnPolyline([ 0 18], poly));

function testPointArray %#ok<*DEFNU>

p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
poly = [p1;p2;p3;p4];

pts = [0 0;15 0;30 0;30 15;30 30;15 30;0 30;0 12;0 18];
exp = [0;.5;1;1.5;2;2.5;3;0;3];

assertElementsAlmostEqual(exp, projPointOnPolyline(pts, poly));
