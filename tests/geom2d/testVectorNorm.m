function test_suite = testVectorNorm(varargin)
% One-line description here, please.
%   output = testVectorNorm(input)
%
%   Example
%   testVectorNorm
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

function testEuclidean

v = [3 4];
norm = vectorNorm(v);
assertAlmostEqual(5, norm);

function testEuclideanArray

v = [3 4;4 3;6 8;5 12];
norm = vectorNorm(v);
assertAlmostEqual([5;5;10;13], norm);

function testExplicitEuclideanArray

v = [3 4;4 3;6 8;5 12];
norm = vectorNorm(v, 2);
assertAlmostEqual([5;5;10;13], norm);

function testNorm1Array

v = [3 4;4 3;6 8;5 12];
norm = vectorNorm(v, 1);
assertAlmostEqual([7;7;14;17], norm);

function testNormInfArray

v = [3 4;4 3;6 8;5 12];
norm = vectorNorm(v, inf);
assertAlmostEqual([4;4;8;12], norm);

