function test_suite = test_isPointOnRay
%TESTISPOINTONRAY  One-line description here, please.
%
%   output = testIsPointOnRay(input)
%
%   Example
%   testIsPointOnRay
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testHoriz(testCase) %#ok<*DEFNU>

p1 = [10 20];
p2 = [80 20];
ray = createRay(p1, p2);

p0 = [10 20];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [80 20];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [50 20];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [9.99 20];
testCase.assertFalse(isPointOnRay(p0, ray));

p0 = [80.01 20];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [50 21];
testCase.assertFalse(isPointOnRay(p0, ray));

p0 = [79 19];
testCase.assertFalse(isPointOnRay(p0, ray));


function testVertical(testCase) %#ok<*DEFNU>

p1 = [20 10];
p2 = [20 80];
ray = createRay(p1, p2);

p0 = [20 10];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [20 80];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [20 50];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [20 9.99];
testCase.assertFalse(isPointOnRay(p0, ray));

p0 = [20 80.01];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [21 50];
testCase.assertFalse(isPointOnRay(p0, ray));

p0 = [19 79];
testCase.assertFalse(isPointOnRay(p0, ray));

function testDiagonal(testCase)

p1 = [10 20];
p2 = [60 70];
ray = createRay(p1, p2);

testCase.assertTrue(isPointOnRay(p1, ray));
testCase.assertTrue(isPointOnRay(p2, ray));

p0 = [11 21];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [59 69];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [9.99 19.99];
testCase.assertFalse(isPointOnRay(p0, ray));

p0 = [60.01 70.01];
testCase.assertTrue(isPointOnRay(p0, ray));

p0 = [30 50.01];
testCase.assertFalse(isPointOnRay(p0, ray));


function testScalarArray(testCase)

ray = [10 20 60 0; 20 10 0 60; 20 10 40 60];
p0 = [20 20];
testCase.assertEqual([true true false], isPointOnRay(p0, ray));

% function testLargeRay
% 
% k = 1e15;
% 
% p1 = [10 20]*k;
% p2 = [60 70]*k;
% ray = createRay(p1, p2);
% 
% testCase.assertTrue(isPointOnRay(p1, ray));
% testCase.assertTrue(isPointOnRay(p2, ray));
% 
% p0 = [11 21]*k;
% testCase.assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [59 69]*k;
% testCase.assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [9.99 19.99]*k;
% testCase.assertFalse(isPointOnRay(p0, ray));
% 
% p0 = [60.01 70.01]*k;
% testCase.assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [30 50.01]*k;
% testCase.assertFalse(isPointOnRay(p0, ray));
% 
% 
% function testSmallray
% 
% k = 1e-10;
% 
% p1 = [10 20]*k;
% p2 = [60 70]*k;
% ray = createRay(p1, p2);
% 
% testCase.assertTrue(isPointOnRay(p1, ray));
% testCase.assertTrue(isPointOnRay(p2, ray));
% 
% p0 = [11 21]*k;
% testCase.assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [59 69]*k;
% testCase.assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [9.99 19.99]*k;
% testCase.assertFalse(isPointOnRay(p0, ray));
% 
% p0 = [60.01 70.01]*k;
% testCase.assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [30 50.01]*k;
% testCase.assertFalse(isPointOnRay(p0, ray));


function testPointArray(testCase)

p1 = [10 20];
p2 = [80 20];
ray = createRay(p1, p2);

p0 = [10 20; 80 20; 50 20;50 21];
exp = [true;true;true;false];
testCase.assertEqual(exp, isPointOnRay(p0, ray));


function testRayArray(testCase)

p1 = [10 20];
p2 = [80 20];
ray = createRay(p1, p2);

p0 = [40 20];
exp = [true true true true];
testCase.assertEqual(exp, isPointOnRay(p0, [ray;ray;ray;ray]));


