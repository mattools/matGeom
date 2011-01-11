function test_suite = testCreateRotationOy(varargin)
%Check creation of rotation around Oy axis
%   output = testCreateRotationOy(input)
%
%   Example
%   testCreateRotationOy
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

trans = createRotationOy(center, theta);

t1 = createTranslation3d(-center);
r0 = createRotationOy(theta);
t2 = createTranslation3d(center);
ctrl = t2*r0*t1;

assertElementsAlmostEqual(ctrl, trans);

