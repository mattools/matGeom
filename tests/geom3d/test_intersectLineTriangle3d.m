function test_suite = test_intersectLineTriangle3d
%TESTINTERSECTLINETRIANGLE3D  One-line description here, please.
%
%   output = testIntersectLineTriangle3d(input)
%
%   Example
%   testIntersectLineTriangle3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-04-08,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testOx(testCase) %#ok<*DEFNU>

p0 = [1 1 1];
dir = [1 0 0];
tri = [2 0 0;2 5 0;2 0 5];

inter = intersectLineTriangle3d([p0 dir], tri);
testCase.assertEqual([2 1 1], inter);

function testInlineTriangle(testCase)

p0 = [1 1 1];
dir = [1 0 0];
tri = [2 0 0 2 5 0 2 0 5];

inter = intersectLineTriangle3d([p0 dir], tri);
testCase.assertEqual([2 1 1], inter);


function testOy(testCase)

p0 = [1 1 1];
dir = [0 1 0];
tri = [0 2 0;5 2 0;0 2 5];

inter = intersectLineTriangle3d([p0 dir], tri);
testCase.assertEqual([1 2 1], inter);


function testOz(testCase)

p0 = [1 1 1];
dir = [0 0 1];
tri = [0 0 2;5 0 2;0 5 2];

inter = intersectLineTriangle3d([p0 dir], tri);
testCase.assertEqual([1 1 2], inter);


