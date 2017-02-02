function test_suite = test_polylineSelfIntersections
%TEST_POLYLINESELFINTERSECTIONS  Test case for the file polylineSelfIntersections
%
%   Test case for the file polylineSelfIntersections

%   Example
%   test_polylineSelfIntersections
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-09-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_SimpleIntersect(testCase) %#ok<*DEFNU>
% Test on a gamma-shaped polyline

poly = [0 0;0 10;20 10;20 20;10 20;10 0];
res = polylineSelfIntersections(poly);
exp = [10 10];

testCase.assertEqual(exp, res, 'AbsTol', .01);

function test_S_Shape(testCase)
% Test on a S-shaped polyline

poly = [10 0;0 0;0 10;20 10;20 20;10 20];

res = polylineSelfIntersections(poly);
exp = zeros(0, 2);
testCase.assertEqual(exp, res);


res = polylineSelfIntersections(poly, 'closed');
exp = [10 10];
testCase.assertEqual(exp, res, 'AbsTol', .01);

