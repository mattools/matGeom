function test_suite = test_vectorAngle
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

test_suite = functiontests(localfunctions); 

function testSingle(testCase) %#ok<*DEFNU>

ang = vectorAngle([1 0]);
testCase.assertEqual(0, ang, 'AbsTol', .01);

ang = vectorAngle([0 1]);
testCase.assertEqual(pi/2, ang, 'AbsTol', .01);

ang = vectorAngle([-1 0]);
testCase.assertEqual(pi, ang, 'AbsTol', .01);

ang = vectorAngle([0 -1]);
testCase.assertEqual(3*pi/2, ang, 'AbsTol', .01);

ang = vectorAngle([-1 1]);
testCase.assertEqual(3*pi/4, ang, 'AbsTol', .01);

function testSinglePiCentered(testCase)

ang = vectorAngle([1 0], pi);
testCase.assertEqual(0, ang, 'AbsTol', .01);

ang = vectorAngle([0 1], pi);
testCase.assertEqual(pi/2, ang, 'AbsTol', .01);

ang = vectorAngle([-1 0], pi);
testCase.assertEqual(pi, ang, 'AbsTol', .01);

ang = vectorAngle([0 -1], pi);
testCase.assertEqual(3*pi/2, ang, 'AbsTol', .01);

ang = vectorAngle([-1 1], pi);
testCase.assertEqual(3*pi/4, ang, 'AbsTol', .01);


function testArray(testCase)

vecs = [1 0;0 1;-1 0;0 -1;1 1];
angs = [0;pi/2;pi;3*pi/2;pi/4];
testCase.assertEqual(angs, vectorAngle(vecs), 'AbsTol', .01);

function testArrayPiCentered(testCase)

vecs = [1 0;0 1;-1 0;0 -1;1 1];
angs = [0;pi/2;pi;3*pi/2;pi/4];
testCase.assertEqual(angs, vectorAngle(vecs, pi), 'AbsTol', .01);

function testSingleZeroCentered(testCase)

ang = vectorAngle([1 0], 0);
testCase.assertEqual(0, ang, 'AbsTol', .01);

ang = vectorAngle([0 1], 0);
testCase.assertEqual(pi/2, ang, 'AbsTol', .01);

ang = vectorAngle([0 -1], 0);
testCase.assertEqual(-pi/2, ang, 'AbsTol', .01);

ang = vectorAngle([-1 1], 0);
testCase.assertEqual(3*pi/4, ang, 'AbsTol', .01);

function testArrayZeroCentered(testCase)

vecs = [1 0;0 1;0 -1;1 1;1 -1];
angs = [0;pi/2;-pi/2;pi/4;-pi/4];
testCase.assertEqual(angs, vectorAngle(vecs, 0), 'AbsTol', .01);

function testCoupleSingleSingle(testCase)

v1 = [1 0];
v2 = [0 1];
ang = pi /2 ;
testCase.assertEqual(ang, vectorAngle(v1, v2), 'AbsTol', .01);

function testCoupleSingleArray(testCase)

v1 = [1 0];
v2 = [0 1; 0 1; 1 1; -1 1];
ang = [pi / 2 ;pi / 2 ;pi / 4 ; 3 * pi / 4];
testCase.assertEqual(ang, vectorAngle(v1, v2), 'AbsTol', .01);


function testCoupleArraySingle(testCase)

v1 = [0 1; 0 1; 1 1; -1 1];
v2 = [-1 0];
ang = [pi / 2 ;pi / 2 ; 3 * pi / 4 ; pi / 4];
testCase.assertEqual(ang, vectorAngle(v1, v2), 'AbsTol', .01);


function testCoupleArrayArray(testCase)

v1 = [1 0; 0 1; 1 1; -1 1];
v2 = [0 1; 1 0; -1 1; -1 0];
ang = [pi / 2 ;3 * pi / 2 ;pi / 2 ; pi / 4];
testCase.assertEqual(ang, vectorAngle(v1, v2), 'AbsTol', .01);
