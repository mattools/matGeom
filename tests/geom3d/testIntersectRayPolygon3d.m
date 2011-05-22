function test_suite = testIntersectRayPolygon3d(varargin) %#ok<STOUT>
%TESTINTERSECTRAYPOLYGON3D  One-line description here, please.
%
%   output = testIntersectRayPolygon3d(input)
%
%   Example
%   testIntersectRayPolygon3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function testTriangle%#ok<*DEFNU>

pts3d = [3 0 0; 0 6 0;0 0 9];
line1 = [0 0 0 1 2 3];

inter = intersectRayPolygon3d(line1, pts3d);
exp = [1 2 3];
assertEqual(exp, inter);

line2 = [10 0 0 1 2 3];

[inter inside] = intersectRayPolygon3d(line2, pts3d); %#ok<ASGLU>
assertFalse(inside);


function testReverseTriangle

pts3d = [3 0 0; 0 6 0;0 0 9];
line1 = [0 0 0 1 2 3];

inter = intersectRayPolygon3d(line1, pts3d);
exp = [1 2 3];
assertEqual(exp, inter);


function testLineArray

pts3d = [3 0 0;0 0 9; 0 6 0];
lines = [0 0 0 3 6 9 ; 10 0 0 3 6 9; 3 6 9 3 6 9];

[inters inside] = intersectRayPolygon3d(lines, pts3d);
assertEqual(3, size(inters, 1));
assertEqual([true;false;false], inside);

