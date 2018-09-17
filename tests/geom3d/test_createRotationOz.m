function test_suite = test_createRotationOz
%Check creation of rotation around Oz axis
%   output = testCreateRotationOz(input)
%
%   Example
%   testCreateRotationOz
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

function testShiftedCenter(testCase) %#ok<*DEFNU>
center = [10 20 30];
theta = pi/3;

trans = createRotationOz(center, theta);

t1 = createTranslation3d(-center);
r0 = createRotationOz(theta);
t2 = createTranslation3d(center);
ctrl = t2*r0*t1;

testCase.assertEqual(ctrl, trans, 'AbsTol', .01);

