function test_suite = testEulerAngles(varargin) %#ok<STOUT>
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

initTestSuite;

function testPositiveAngles %#ok<*DEFNU>

mat = eulerAnglesToRotation3d(10, 20, 30);
[phi theta psi] = rotation3dToEulerAngles(mat);

assertElementsAlmostEqual(10, phi);
assertElementsAlmostEqual(20, theta);
assertElementsAlmostEqual(30, psi);


function testNegativeAngles

mat = eulerAnglesToRotation3d(-10, -20, -30);
[phi theta psi] = rotation3dToEulerAngles(mat);

assertElementsAlmostEqual(-10, phi);
assertElementsAlmostEqual(-20, theta);
assertElementsAlmostEqual(-30, psi);
