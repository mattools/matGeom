function test_suite = test_isPointOnRay(varargin) %#ok<STOUT>
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

initTestSuite;

function testHoriz %#ok<*DEFNU>

p1 = [10 20];
p2 = [80 20];
ray = createRay(p1, p2);

p0 = [10 20];
assertTrue(isPointOnRay(p0, ray));

p0 = [80 20];
assertTrue(isPointOnRay(p0, ray));

p0 = [50 20];
assertTrue(isPointOnRay(p0, ray));

p0 = [9.99 20];
assertFalse(isPointOnRay(p0, ray));

p0 = [80.01 20];
assertTrue(isPointOnRay(p0, ray));

p0 = [50 21];
assertFalse(isPointOnRay(p0, ray));

p0 = [79 19];
assertFalse(isPointOnRay(p0, ray));


function testVertical %#ok<*DEFNU>

p1 = [20 10];
p2 = [20 80];
ray = createRay(p1, p2);

p0 = [20 10];
assertTrue(isPointOnRay(p0, ray));

p0 = [20 80];
assertTrue(isPointOnRay(p0, ray));

p0 = [20 50];
assertTrue(isPointOnRay(p0, ray));

p0 = [20 9.99];
assertFalse(isPointOnRay(p0, ray));

p0 = [20 80.01];
assertTrue(isPointOnRay(p0, ray));

p0 = [21 50];
assertFalse(isPointOnRay(p0, ray));

p0 = [19 79];
assertFalse(isPointOnRay(p0, ray));

function testDiagonal

p1 = [10 20];
p2 = [60 70];
ray = createRay(p1, p2);

assertTrue(isPointOnRay(p1, ray));
assertTrue(isPointOnRay(p2, ray));

p0 = [11 21];
assertTrue(isPointOnRay(p0, ray));

p0 = [59 69];
assertTrue(isPointOnRay(p0, ray));

p0 = [9.99 19.99];
assertFalse(isPointOnRay(p0, ray));

p0 = [60.01 70.01];
assertTrue(isPointOnRay(p0, ray));

p0 = [30 50.01];
assertFalse(isPointOnRay(p0, ray));


function testScalarArray

ray = [10 20 60 0; 20 10 0 60; 20 10 40 60];
p0 = [20 20];
assertEqual([true true false], isPointOnRay(p0, ray));

% function testLargeRay
% 
% k = 1e15;
% 
% p1 = [10 20]*k;
% p2 = [60 70]*k;
% ray = createRay(p1, p2);
% 
% assertTrue(isPointOnRay(p1, ray));
% assertTrue(isPointOnRay(p2, ray));
% 
% p0 = [11 21]*k;
% assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [59 69]*k;
% assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [9.99 19.99]*k;
% assertFalse(isPointOnRay(p0, ray));
% 
% p0 = [60.01 70.01]*k;
% assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [30 50.01]*k;
% assertFalse(isPointOnRay(p0, ray));
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
% assertTrue(isPointOnRay(p1, ray));
% assertTrue(isPointOnRay(p2, ray));
% 
% p0 = [11 21]*k;
% assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [59 69]*k;
% assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [9.99 19.99]*k;
% assertFalse(isPointOnRay(p0, ray));
% 
% p0 = [60.01 70.01]*k;
% assertTrue(isPointOnRay(p0, ray));
% 
% p0 = [30 50.01]*k;
% assertFalse(isPointOnRay(p0, ray));


function testPointArray

p1 = [10 20];
p2 = [80 20];
ray = createRay(p1, p2);

p0 = [10 20; 80 20; 50 20;50 21];
exp = [true;true;true;false];
assertEqual(exp, isPointOnRay(p0, ray));


function testRayArray

p1 = [10 20];
p2 = [80 20];
ray = createRay(p1, p2);

p0 = [40 20];
exp = [true true true true];
assertEqual(exp, isPointOnRay(p0, [ray;ray;ray;ray]));


