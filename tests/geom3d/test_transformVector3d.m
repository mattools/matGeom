function test_suite = test_transformVector3d
%Check transformation of points
%   output = testTransformVector3d(input)
%
%   Example
%   testTransformVector3d
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

function testTranslation(testCase) %#ok<*DEFNU>
v0 = [1 2 3];
v  = [4 5 6];
trans = createTranslation3d(v);

vt = transformVector3d(v0, trans);
ctrl = v0;
testCase.assertEqual(ctrl, vt, 'AbsTol', .01);


function testRotationOx(testCase)
v0 = [10 20 30];
trans = createRotationOx([10 10 10], pi/2);

vt = transformVector3d(v0, trans);
ctrl = [10 -30 20];
testCase.assertEqual(ctrl, vt, 'AbsTol', .01);

