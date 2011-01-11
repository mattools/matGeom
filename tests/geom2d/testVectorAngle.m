function test_suite = testVectorAngle(varargin)
% One-line description here, please.
%   output = testVectorAngle(input)
%
%   Example
%   testVectorAngle
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

function testSingle

ang = vectorAngle([1 0]);
assertAlmostEqual(0, ang);

ang = vectorAngle([0 1]);
assertAlmostEqual(pi/2, ang);

ang = vectorAngle([-1 0]);
assertAlmostEqual(pi, ang);

ang = vectorAngle([0 -1]);
assertAlmostEqual(3*pi/2, ang);

ang = vectorAngle([-1 1]);
assertAlmostEqual(3*pi/4, ang);

function testSinglePiCentered 

ang = vectorAngle([1 0], pi);
assertAlmostEqual(0, ang);

ang = vectorAngle([0 1], pi);
assertAlmostEqual(pi/2, ang);

ang = vectorAngle([-1 0], pi);
assertAlmostEqual(pi, ang);

ang = vectorAngle([0 -1], pi);
assertAlmostEqual(3*pi/2, ang);

ang = vectorAngle([-1 1], pi);
assertAlmostEqual(3*pi/4, ang);


function testArray

vecs = [1 0;0 1;-1 0;0 -1;1 1];
angs = [0;pi/2;pi;3*pi/2;pi/4];
assertElementsAlmostEqual(angs, vectorAngle(vecs));

function testArrayPiCentered

vecs = [1 0;0 1;-1 0;0 -1;1 1];
angs = [0;pi/2;pi;3*pi/2;pi/4];
assertElementsAlmostEqual(angs, vectorAngle(vecs, pi));

function testSingleZeroCentered

ang = vectorAngle([1 0], 0);
assertAlmostEqual(0, ang);

ang = vectorAngle([0 1], 0);
assertAlmostEqual(pi/2, ang);

ang = vectorAngle([0 -1], 0);
assertAlmostEqual(-pi/2, ang);

ang = vectorAngle([-1 1], 0);
assertAlmostEqual(3*pi/4, ang);

function testArrayZeroCentered

vecs = [1 0;0 1;0 -1;1 1;1 -1];
angs = [0;pi/2;-pi/2;pi/4;-pi/4];
assertElementsAlmostEqual(angs, vectorAngle(vecs, 0));
