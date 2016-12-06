function test_suite = test_edgePosition(varargin) %#ok<STOUT>
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

initTestSuite;

function test_Simple %#ok<*DEFNU>
% Test call of function without argument

edge = [10 10 30 20];
p1 = [10 10];
p2 = [20 15];
p3 = [30 20];

pos1 = edgePosition(p1, edge);
pos2 = edgePosition(p2, edge);
pos3 = edgePosition(p3, edge);

assertElementsAlmostEqual(0, pos1);
assertElementsAlmostEqual(.5, pos2);
assertElementsAlmostEqual(1, pos3);


function test_MultipleEdges

edges = [10 10 30 10 ; 10 10 0 0 ; 0 0 20 20];
point = [10 10];

posList = edgePosition(point, edges);

assertElementsAlmostEqual([0 0 .5], posList);


function test_MultiplePoints

edge = [10 10 30 20];
points = [10 10; 20 15; 30 20; 15 12.5];

posList = edgePosition(points, edge);

assertElementsAlmostEqual([0; .5; 1; .25], posList);


