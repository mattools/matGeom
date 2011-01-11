function test_suite = testTransformLine3d(varargin)
%Check transformation of 3Dlines
%   output = testTransformLine3d(input)
%
%   Example
%   testTransformLine3d
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
p0 = [1 2 3];
v0 = [4 5 6];
line = [p0 v0];

shift   = [7 8 9];
trans   = createTranslation3d(shift);

linet   = transformLine3d(line, trans);
ctrl    = [p0+shift v0];
assertElementsAlmostEqual(ctrl, linet);


function testRotationOx
p1 = [1 2 3];
p2 = [4 5 6];
line = createLine3d(p1, p2);

trans   = createRotationOx([2 3 1], pi/3);

linet   = transformLine3d(line, trans);

p1t     = transformPoint3d(p1, trans);
p2t     = transformPoint3d(p2, trans);
ctrl    = createLine3d(p1t, p2t);

assertElementsAlmostEqual(ctrl, linet);

