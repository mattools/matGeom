function test_suite = test_polygonArea3d
%TEST_POLYGONAREA3D  Test case for the file polygonArea3d
%
%   Test case for the file polygonArea3d

%   Example
%   test_polygonArea3d
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
poly = [0 0 10;10 0 10;10 10 10;0 10 10];
area = polygonArea3d(poly);
testCase.assertEqual(100, area);


function test_MShape(testCase)
% A more complicated shape that involves negative triangle areas
poly = [0 0 10;0 -40 10;20 40 10;40 -40 10;40 60 10;0 60 10];
area = polygonArea3d(poly);

% area equals 20*40 + 2 * (20 * 80) / 2 = 800 + 1600 = 2400
testCase.assertEqual(2400, area);

function test_colinearEdges(testCase)
% a polygon with two colinear edges, inducing potential bug in cross
% product computations

poly = [0 0 10 ; 5 0 10; 10 0 10; 10 10 10; 0 10 10];
exp = 100;

area = polygonArea3d(poly);

testCase.assertEqual(exp, area);
