function test_suite = test_medianLine
%TESTMEDIANLINE  One-line description here, please.
%   output = testMedianLine(input)
%
%   Example
%   testMedianLine
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

test_suite = functiontests(localfunctions); 

function testTwoPoints(testCase) %#ok<*DEFNU>
% test with 2 points

p1 = [0 0];
p2 = [10 0];
exp = [5 0 0 10];
line = medianLine(p1, p2);
testCase.assertEqual(exp, line, 'AbsTol', .01);

function testEdge(testCase) 
% test with an edge as input

p1 = [0 0];
p2 = [10 0];
exp = [5 0 0 10];
line = medianLine([p1 p2]);
testCase.assertEqual(exp, line, 'AbsTol', .01);

function testTwoPointArrays(testCase) %#ok<*DEFNU>
% test with 2 points

p1 = [0 0; 10 10];
p2 = [10 0;10 20];

exp = [5 0 0 10; 10 15 -10 0];

line = medianLine(p1, p2);
testCase.assertEqual(exp, line, 'AbsTol', .01);
