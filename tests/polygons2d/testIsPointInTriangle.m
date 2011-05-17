function test_suite = testIsPointInTriangle(varargin)
%TESTISPOINTINTRIANGLE  One-line description here, please.
%
%   output = testIsPointInTriangle(input)
%
%   Example
%   testIsPointInTriangle
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-17,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function testSimple %#ok<*DEFNU>

p1 = [0 0];
p2 = [10 0];
p3 = [5 10];
tri = [p1;p2;p3];

res1 = isPointInTriangle([0 0], tri);
assertTrue(res1);

res2 = isPointInTriangle([5 5], tri);
assertTrue(res2);

res3 = isPointInTriangle([10 5], tri);
assertFalse(res3);

function testArray

p1 = [0 0];
p2 = [10 0];
p3 = [5 10];
tri = [p1;p2;p3];

res = isPointInTriangle([0 0;1 0;0 1], tri);
exp = [true;true;false];
assertEqual(exp, res);
