function test_suite = test_intersectLineSphere
%TESTINTERSECTLINESPHERE  One-line description here, please.
%
%   output = testIntersectLineSphere(input)
%
%   Example
%   testIntersectLineSphere
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testOx(testCase) %#ok<*DEFNU>

center = [10 20 30];
radius = 50;

line = [center 6 0 0];

inter = intersectLineSphere(line, [center radius]);

exp = [...
    center(1)-radius center(2) center(3); ... 
    center(1)+radius center(2) center(3)];
testCase.assertEqual(exp, inter, 'AbsTol', .01);


function testOy(testCase)

center = [10 20 30];
radius = 50;

line = [center 0 6 0];

inter = intersectLineSphere(line, [center radius]);

exp = [...
    center(1) center(2)-radius center(3); ... 
    center(1) center(2)+radius center(3)];
testCase.assertEqual(exp, inter, 'AbsTol', .01);


function testOz(testCase)

center = [10 20 30];
radius = 50;

line = [center 0 0 6];

inter = intersectLineSphere(line, [center radius]);

exp = [...
    center(1) center(2) center(3)-radius; ... 
    center(1) center(2) center(3)+radius];
testCase.assertEqual(exp, inter, 'AbsTol', .01);


function testMultiLine(testCase)

center = [10 20 30];
radius = 50;
sphere  = [center radius];

line1 = [center 6 0 0];
line2 = [center 0 6 0];
line3 = [center 0 0 6];
lines = [line1 ; line2 ; line3];


inter = intersectLineSphere(lines, sphere);


