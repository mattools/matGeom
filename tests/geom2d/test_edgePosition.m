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

assertEqual(testCase, 0, pos1, 'AbsTol', .01);
assertEqual(testCase, .5, pos2, 'AbsTol', .01);
assertEqual(testCase, 1, pos3, 'AbsTol', .01);


function test_MultipleEdges(testCase)

edges = [10 10 30 10 ; 10 10 0 0 ; 0 0 20 20];
point = [10 10];

posList = edgePosition(point, edges);

assertEqual(testCase, [0 0 .5], posList, 'AbsTol', .01);


function test_MultiplePoints(testCase)

edge = [10 10 30 20];
points = [10 10; 20 15; 30 20; 15 12.5];

posList = edgePosition(points, edge);

assertEqual(testCase, [0; .5; 1; .25], posList, 'AbsTol', .01);


function test_ArrayArray(testCase)

points = [ 5 20; 10 20; 20 20; 30 20; 35 20];
edges = [10 20 20 20;20 20 30 20];

posList = edgePosition(points, edges);

exp = [-0.5 -1.5;0.0 -1.0;1.0 0.0;2.0 1.0;2.5 1.5];
assertEqual(testCase, size(posList), [5 2]);
assertEqual(testCase, posList, exp, 'AbsTol', .01);


function test_diag(testCase)

points = [14 20;26 20];
edges = [10 20 20 20;20 20 30 20];

posList = edgePosition(points, edges, 'diag');

exp = [0.4;0.6];
assertEqual(testCase, size(posList), [2 1]);
assertEqual(testCase, posList, exp, 'AbsTol', .01);

