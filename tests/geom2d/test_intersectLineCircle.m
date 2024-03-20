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
% Should find two distinct points.

center = [10 0];
l1 = [center 0 1];
c1 = [center 5];

pts = intersectLineCircle(l1, c1);

exp = [10 -5; 10 5];
assertEqual(testCase, exp, pts, 'AbsTol', .01);


function testTangentLine(testCase)
% Should find twice the same point.

center = [10 0];
l1 = [15 0 0 1];
c1 = [center 5];

pts = intersectLineCircle(l1, c1);

exp = [15 0;15 0];
assertEqual(testCase, exp, pts, 'AbsTol', .01);


function testNoIntersect(testCase)
% Should return a 2-by-2 array full of NaN.

center = [10 0];
l1 = [16 0 0 1];
c1 = [center 5];

pts = intersectLineCircle(l1, c1);

exp = [NaN NaN;NaN NaN];
assertEqual(testCase, exp, pts);


function test_ManyLines_ManyCircles(testCase) %#ok<*DEFNU>

lines    = [ 0 0 1 0; 0 0 0 1];
circles = [ 0 0 1 ; 0 0 2];
intersectLineCircle (lines, circles);

pts = intersectLineCircle(lines, circles);

assertEqual(testCase, size(pts), [2 2 2]);


function test_ManyLines_ManyCircles_Tangents(testCase) %#ok<*DEFNU>

lines    = [ 0 0 1 0; 2 2 1 0];
circles = [ 0 0 1 ; 0 0 1];
intersectLineCircle (lines, circles);

pts = intersectLineCircle(lines, circles);

assertEqual(testCase, size(pts), [2 2]);

