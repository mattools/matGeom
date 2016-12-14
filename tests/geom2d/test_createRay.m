function test_suite = test_createRay
%testCreateRay  One-line description here, please.
%   output = testCreateRay(input)
%
%   Example
%   testCreateRay
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

test_suite = functiontests(localfunctions);

function testCreateRay2Points(testCase) %#ok<*DEFNU>

p1 = [1 1];
p2 = [2 3];
ray = createRay(p1, p2);

testCase.assertEqual(p1, ray(1,1:2), 'AbsTol', .01);
testCase.assertEqual(p2-p1, ray(1,3:4), 'AbsTol', .01);

function testCreateRay2Arrays(testCase)

p1 = [1 1;1 1];
p2 = [2 3;2 4];
ray = createRay(p1, p2);

testCase.assertEqual(2, size(ray, 1), 'AbsTol', .01);
testCase.assertEqual(p1, ray(:,1:2), 'AbsTol', .01);
testCase.assertEqual(p2-p1, ray(:,3:4), 'AbsTol', .01);

