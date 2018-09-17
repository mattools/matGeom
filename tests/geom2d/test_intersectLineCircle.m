function  test_suite = test_intersectLineCircle 
%TESTINTERSECTLINECIRCLE  One-line description here, please.
%
%   output = testIntersectLineCircle(input)
%
%   Example
%   testIntersectLineCircle
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 


function testIntersect(testCase) %#ok<*DEFNU>

center = [10 0];
l1 = [center 0 1];
c1 = [center 5];
pts = intersectLineCircle(l1, c1);
exp = [10 -5; 10 5];
testCase.assertEqual(exp, pts, 'AbsTol', .01);

function testTangent(testCase)

center = [10 0];
l1 = [15 0 0 1];
c1 = [center 5];
pts = intersectLineCircle(l1, c1);
exp = [15 0;15 0];
testCase.assertEqual(exp, pts, 'AbsTol', .01);

function testNoIntersect(testCase)

center = [10 0];
l1 = [16 0 0 1];
c1 = [center 5];
pts = intersectLineCircle(l1, c1);
exp = [NaN NaN;NaN NaN];
testCase.assertEqual(exp, pts);

