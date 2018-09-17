function test_suite = test_intersectCircles 
%TESTINTERSECTCIRCLES  One-line description here, please.
%   output = testIntersectCircles(input)
%
%   Example
%   testIntersectCircles
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


function testTwoCircles(testCase) %#ok<*DEFNU>

r = 10;
c1 = [0 0 r];
c2 = [r 0 r];

h = r*sqrt(3)/2;
exp = [r/2 -h ; r/2 h];

inters = intersectCircles(c1, c2);
testCase.assertEqual(exp, inters, 'AbsTol', .01);

function testTangentCircles(testCase)

r = 10;
c1 = [0 0 r];
c2 = [2*r 0 r];

exp = [r 0;r 0];
inters = intersectCircles(c1, c2);
testCase.assertEqual(exp, inters, 'AbsTol', .01);

function testArrays(testCase)

r = 10;
c1 = [0 0 r];
c2 = [r 0 r];
c3 = [0 r r];

inters = intersectCircles(c1, [c2;c3]);
testCase.assertEqual(4, size(inters, 1));

inters = intersectCircles([c2;c3], c1);
testCase.assertEqual(4, size(inters, 1));

inters = intersectCircles([c1;c1], [c2;c3]);
testCase.assertEqual(4, size(inters, 1));
