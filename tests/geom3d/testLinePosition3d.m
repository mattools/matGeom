function test_suite = testLinePosition3d(varargin) %#ok<STOUT>
%TESTLINEPOSITION3D  One-line description here, please.
%
%   output = testLinePosition3d(input)
%
%   Example
%   testLinePosition3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-11-16,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


initTestSuite;

function testSimple %#ok<*DEFNU>

p0 = [10 20 30];
v0 = [40 50 60];
line = [p0 v0];

pos0 = linePosition3d(p0, line);
assertEqual(0, pos0);

p1 = p0 + v0;
pos1 = linePosition3d(p1, line);
assertEqual(1, pos1);


function testPointArray

p0 = [10 20 30];
v0 = [40 50 60];
line = [p0 v0];

points = [p0; p0+v0; p0-v0; p0+3*v0];

pos = linePosition3d(points, line);
exp = [0;1;-1;3];
assertEqual(exp, pos);


function testLineArray

p0 = [10 20 30];

v1 = [1 0 0];
line1 = [p0 v1];
v2 = [0 1 0];
line2 = [p0 v2];
v3 = [0 0 1];
line3 = [p0 v3];
lines = [line1;line2;line3];

pos = linePosition3d(p0, lines);
exp = [0;0;0];
assertEqual(exp, pos);


function testTwoArraysSameSize

p0 = [10 20 30];

v1 = [3 0 0];
line1 = [p0 v1];
v2 = [0 4 0];
line2 = [p0 v2];
v3 = [0 0 5];
line3 = [p0 v3];
v4 = [3 4 5];
line4 = [p0 v4];
lines = [line1;line2;line3;line4];

points = [p0+2*v1;p0+3*v2;p0+4*v3;p0+v1+v2+v3];
pos = linePosition3d(points, lines);
exp = [2;3;4;1];
assertEqual(exp, pos);

