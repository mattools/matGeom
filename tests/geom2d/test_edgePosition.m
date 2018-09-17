function test_suite = test_edgePosition 
%TEST_EDGEPOSITION  Test case for the file edgePosition
%
%   Test case for the file edgePosition

%   Example
%   test_edgePosition
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@nnates.inra.fr
% Created: 2016-07-19,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2016 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument

edge = [10 10 30 20];
p1 = [10 10];
p2 = [20 15];
p3 = [30 20];

pos1 = edgePosition(p1, edge);
pos2 = edgePosition(p2, edge);
pos3 = edgePosition(p3, edge);

testCase.assertEqual(0, pos1, 'AbsTol', .01);
testCase.assertEqual(.5, pos2, 'AbsTol', .01);
testCase.assertEqual(1, pos3, 'AbsTol', .01);


function test_MultipleEdges(testCase)

edges = [10 10 30 10 ; 10 10 0 0 ; 0 0 20 20];
point = [10 10];

posList = edgePosition(point, edges);

testCase.assertEqual([0 0 .5], posList, 'AbsTol', .01);


function test_MultiplePoints(testCase)

edge = [10 10 30 20];
points = [10 10; 20 15; 30 20; 15 12.5];

posList = edgePosition(points, edge);

testCase.assertEqual([0; .5; 1; .25], posList, 'AbsTol', .01);


