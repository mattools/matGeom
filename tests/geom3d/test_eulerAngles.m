function test_suite = test_eulerAngles
%TESTEULERANGLES Test conversion euler angles <-> rotaion matrix
%
%   output = testEulerAngles(input)
%
%   Example
%   testEulerAngles
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testPositiveAngles(testCase) %#ok<*DEFNU>

mat = eulerAnglesToRotation3d(10, 20, 30);
[phi, theta, psi] = rotation3dToEulerAngles(mat);

testCase.assertEqual(10, phi, 'AbsTol', .01);
testCase.assertEqual(20, theta, 'AbsTol', .01);
testCase.assertEqual(30, psi, 'AbsTol', .01);


function testNegativeAngles(testCase)

mat = eulerAnglesToRotation3d(-10, -20, -30);
[phi, theta, psi] = rotation3dToEulerAngles(mat);

testCase.assertEqual(-10, phi, 'AbsTol', .01);
testCase.assertEqual(-20, theta, 'AbsTol', .01);
testCase.assertEqual(-30, psi, 'AbsTol', .01);
