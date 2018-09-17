function test_suite = test_createScaling3d
%Check creation of rotation around Ox axis
%   output = testCreateRotationOx(input)
%
%   Example
%   testCreateRotationOx
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testUniform(testCase) %#ok<*DEFNU>

k = 3;
trans = createScaling3d(k);

testCase.assertEqual(k, trans(1,1), 'AbsTol', .01);
testCase.assertEqual(k, trans(2,2), 'AbsTol', .01);
testCase.assertEqual(k, trans(3,3), 'AbsTol', .01);

function testNonUniform(testCase) %#ok<*DEFNU>

k = [3 4 5];
trans = createScaling3d(k);

testCase.assertEqual(k(1), trans(1,1), 'AbsTol', .01);
testCase.assertEqual(k(2), trans(2,2), 'AbsTol', .01);
testCase.assertEqual(k(3), trans(3,3), 'AbsTol', .01);

function testNonUniform2(testCase) %#ok<*DEFNU>

trans = createScaling3d(3, 4, 5);

testCase.assertEqual(3, trans(1,1), 'AbsTol', .01);
testCase.assertEqual(4, trans(2,2), 'AbsTol', .01);
testCase.assertEqual(5, trans(3,3), 'AbsTol', .01);

function testUniformNonCentered(testCase) %#ok<*DEFNU>

center = [2 3 4];
k = 3;

trans = createScaling3d(center, k);
tra = createTranslation3d(center);
sca = createScaling3d(k);
exp = tra * sca * inv(tra);

testCase.assertEqual(exp(1,1), trans(1,1), 'AbsTol', .01);
testCase.assertEqual(exp(2,2), trans(2,2), 'AbsTol', .01);
testCase.assertEqual(exp(3,3), trans(3,3), 'AbsTol', .01);
testCase.assertEqual(exp(1,4), trans(1,4), 'AbsTol', .01);
testCase.assertEqual(exp(2,4), trans(2,4), 'AbsTol', .01);
testCase.assertEqual(exp(3,4), trans(3,4), 'AbsTol', .01);

function testNonUniformNonCentered(testCase) %#ok<*DEFNU>

center = [5 6 7];
k = [2 3 3];

trans = createScaling3d(center, k);
tra = createTranslation3d(center);
sca = createScaling3d(k);
exp = tra * sca * inv(tra);

testCase.assertEqual(exp(1,1), trans(1,1), 'AbsTol', .01);
testCase.assertEqual(exp(2,2), trans(2,2), 'AbsTol', .01);
testCase.assertEqual(exp(3,3), trans(3,3), 'AbsTol', .01);
testCase.assertEqual(exp(1,4), trans(1,4), 'AbsTol', .01);
testCase.assertEqual(exp(2,4), trans(2,4), 'AbsTol', .01);
testCase.assertEqual(exp(3,4), trans(3,4), 'AbsTol', .01);

