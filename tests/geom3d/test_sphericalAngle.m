function test_suite = test_sphericalAngle
%TESTSPHERICALANGLE  One-line description here, please.
%
%   output = testSphericalAngle(input)
%
%   Example
%   testSphericalAngle
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

function testP2At100(testCase) %#ok<*DEFNU>

p2 = [1 0 0];
p1 = [0 1 0];
p3 = [0 0 1];

alpha = sphericalAngle(p1, p2, p3);

testCase.assertEqual(pi/2, alpha);

% try in the other direction
alpha = sphericalAngle(p3, p2, p1);

testCase.assertEqual(3*pi/2, alpha, 'AbsTol', 1e-4);

function testP2At010(testCase)

p1 = [1 0 0];
p2 = [0 1 0];
p3 = [0 0 1];

alpha = sphericalAngle(p1, p2, p3);

testCase.assertEqual(3*pi/2, alpha);

% try in the other direction
alpha = sphericalAngle(p3, p2, p1);

testCase.assertEqual(pi/2, alpha, 'AbsTol', 1e-4);


function testSpherical(testCase)

sph1 = [.1 0];
sph2 = [0 0];
sph3 = [0 .1];

alpha = sphericalAngle(sph1, sph2, sph3);
testCase.assertEqual(pi/2, alpha, 'AbsTol', 1e-4);
