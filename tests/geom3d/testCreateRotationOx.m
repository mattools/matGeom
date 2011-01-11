function test_suite = testCreateRotationOx(varargin)
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

initTestSuite;

function testShiftedCenter
center = [10 20 30];
theta = pi/3;

trans = createRotationOx(center, theta);

t1 = createTranslation3d(-center);
r0 = createRotationOx(theta);
t2 = createTranslation3d(center);
ctrl = t2*r0*t1;

assertElementsAlmostEqual(ctrl, trans);

