function test_suite = test_edgeLength 
% One-line description here, please.
%   output = testEdgeLength(input)
%
%   Example
%   testEdgeLength
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testSimple(testCase) %#ok<*DEFNU>

p1 = [2 3];
p2 = [5 7];
edge = createEdge(p1, p2);
len = edgeLength(edge);
testCase.assertEqual(5, len, 'AbsTol', .01);

function testArray(testCase)

p1 = [2 3;2 3;3 2;5 7];
p2 = [5 7;5 7;7 5;2 3];
edge = createEdge(p1, p2);
len = edgeLength(edge);

testCase.assertEqual(4, size(len, 1));
testCase.assertEqual([5;5;5;5], len, 'AbsTol', .01);

