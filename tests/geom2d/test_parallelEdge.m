function test_suite = test_parallelEdge
%TEST_PARALLELEDGE  Test case for the file parallelEdge
%
%   Test case for the file parallelEdge

%   Example
%   test_parallelEdge
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

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument

exp = [10 15 30 15];
res = parallelEdge([10 20 30 20], 5);
testCase.assertEqual(exp, res, 'AbsTol', .01);


function test_Array(testCase)
% Test call of function without argument

edges = [10 20 30 20; 30 20 10 20];
res = parallelEdge(edges, 5);

exp = [10 15 30 15; 30 25 10 25];
testCase.assertEqual(exp, res, 'AbsTol', .01);
