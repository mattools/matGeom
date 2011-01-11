function test_suite = testTransformVector3d(varargin)
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

initTestSuite;

function testTranslation
v0 = [1 2 3];
v  = [4 5 6];
trans = createTranslation3d(v);

vt = transformVector3d(v0, trans);
ctrl = v0;
assertElementsAlmostEqual(ctrl, vt);


function testRotationOx
v0 = [10 20 30];
trans = createRotationOx([10 10 10], pi/2);

vt = transformVector3d(v0, trans);
ctrl = [10 -30 20];
assertElementsAlmostEqual(ctrl, vt);

