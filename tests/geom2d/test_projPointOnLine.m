function test_suite = test_projPointOnLine(varargin) %#ok<STOUT>
%TESTPROJPOINTONLINE  One-line description here, please.
%   output = testProjPointOnLine(input)
%
%   Example
%   testProjPointOnLine
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

initTestSuite;

function testHorizontal %#ok<*DEFNU>
point = [0 0];
line = [1 0 0 1];
assertElementsAlmostEqual(projPointOnLine(point, line), [1 0]);

function testDiagonal
point = [0 0];
line = [2 0 1 1];
assertElementsAlmostEqual(projPointOnLine(point, line), [1 -1], 'absolute', 1e-14);

function testBigDerivative
point = [0 0];
line = [2 0 1000 1000];
assertElementsAlmostEqual(projPointOnLine(point, line), [1 -1], 'absolute', 1e-14);

function testDiagonal2
point = [2 3];
line = [-2 -4 6 4];
assertElementsAlmostEqual(projPointOnLine(point, line), [4 0], 'absolute', 1e-14);

function test_SingleMulti

point = [4 2];
line1 = [0 0 1 0];
line2 = [0 0 0 1];
line3 = [0 2 2 2];

res = projPointOnLine(point, [line1;line2;line3]);
exp = [4 0;0 2;2 4];
assertElementsAlmostEqual(exp, res);

function test_MultiSingle

line = [0 2 4 2];
p1 = [3 1];
p2 = [5 2];
p3 = [3 6];

res = projPointOnLine([p1;p2;p3], line);
exp = [2 3;4 4;4 4];
assertElementsAlmostEqual(exp, res);

function test_MultiMulti

line1 = [0 0 1 0];
line2 = [0 0 0 1];
line3 = [0 2 2 2];
p1 = [3 1];
p2 = [2 3];
p3 = [1 5];
res = projPointOnLine([p1;p2;p3], [line1;line2;line3]);
exp = [3 0;0 3;2 4];
assertElementsAlmostEqual(exp, res);
