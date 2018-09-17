function test_suite = test_intersectEdgePolygon
%TEST_INTERSECTEDGEPOLYGON  Test case for the file intersectEdgePolygon
%
%   Test case for the file intersectEdgePolygon

%   Example
%   test_intersectEdgePolygon
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Square(testCase) %#ok<*DEFNU>
% Test call of function without argument
poly = [0 0;10 0;10 10;0 10];
edge = [9 2 9+3*1 2+3*2];
exp = [10 4];
inter = intersectEdgePolygon(edge, poly);
testCase.assertEqual(exp, inter);

function test_GetIndex(testCase)
% Test call of function without argument
poly = [0 0;10 0;10 10;0 10];
edge = [9 2 9+3*1 2+3*2];
exp = [10 4];
[inter, index] = intersectEdgePolygon(edge, poly);
testCase.assertEqual(exp, inter);
testCase.assertEqual(2, index);

function test_NoIntersect(testCase)
% Test call of function without argument
poly = [0 0;10 0;10 10;0 10];
edge = [2 3 8 6];
inter = intersectEdgePolygon(edge, poly);
testCase.assertTrue(isempty(inter));
