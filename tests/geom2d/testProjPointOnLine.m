function test_suite = testProjPointOnLine(varargin)
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
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;

function testHorizontal
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
