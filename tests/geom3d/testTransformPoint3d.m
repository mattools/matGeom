function test_suite = testTransformPoint3d(varargin) %#ok<STOUT>
%Check transformation of points
%   output = testTransformPoint3d(input)
%
%   Example
%   testTransformPoint3d
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

function testTranslation %#ok<*DEFNU>
p0 = [1 2 3];
v  = [4 5 6];
trans = createTranslation3d(v);

pt = transformPoint3d(p0, trans);
ctrl = p0 + v;
assertElementsAlmostEqual(ctrl, pt);


function testRotationOx
p0 = [10 20 30];
trans = createRotationOx([10 10 10], pi/2);

pt = transformPoint3d(p0, trans);
ctrl = [10 -10 20];
assertElementsAlmostEqual(ctrl, pt);

