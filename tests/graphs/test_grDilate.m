function test_suite = test_grDilate
%TEST_GRDILATE  test suite for function grDilate
%
%   output = test_grDilate(input)
%
%   Example
%   testGrDilate
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

function testSimpleGraph(testCase) %#ok<*DEFNU>

[nodes, edges, values] = createTestGraph01(); %#ok<ASGLU>

valDil = grDilate(edges, values);
exp = [80;80;70;70;80;50;80;40];
testCase.assertEqual(exp, valDil);

