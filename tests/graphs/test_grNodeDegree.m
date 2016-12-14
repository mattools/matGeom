function test_suite = test_grNodeDegree
%TEST_GRNODEDEGREE  test suite for function grNodeDegree
%
%   output = test_grNodeDegree(input)
%
%   Example
%   testGrNodeDegree
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-18,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


test_suite = functiontests(localfunctions); 

function testSimpleNode(testCase) %#ok<*DEFNU>

[nodes, edges] = createTestGraph01(); %#ok<ASGLU>

deg1 = grNodeDegree(1, edges);
testCase.assertEqual(3, deg1);


function testAllNodes(testCase)

[nodes, edges] = createTestGraph01(); %#ok<ASGLU>

deg = grNodeDegree(1:8, edges);
exp = [3 3 2 2 4 2 3 1];
testCase.assertEqual(exp, deg);

