function test_suite = test_transformPoint3d
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

test_suite = functiontests(localfunctions); 

function testTranslation(testCase) %#ok<*DEFNU>
p0 = [1 2 3];
v  = [4 5 6];
trans = createTranslation3d(v);

pt = transformPoint3d(p0, trans);
ctrl = p0 + v;
assertEqual(testCase, ctrl, pt, 'AbsTol', .01);


function testTranslation_separateCoords(testCase) %#ok<*DEFNU>
p0 = [1 2 3];
v  = [4 5 6];
trans = createTranslation3d(v);

pt = transformPoint3d(p0(1), p0(2), p0(3), trans);

ctrl = p0 + v;
assertEqual(testCase, ctrl, pt, 'AbsTol', .01);


function testTranslation_Array(testCase)

p0 = [1 2 3;10 20 30;10 20 30];
v  = [4 5 6];
trans = createTranslation3d(v);

pt = transformPoint3d(p0, trans);

ctrl = p0 + repmat(v, 3, 1);
assertEqual(testCase, ctrl, pt, 'AbsTol', .01);


function testRotationOx(testCase)

p0 = [10 20 30];
trans = createRotationOx([10 10 10], pi/2);

pt = transformPoint3d(p0, trans);

ctrl = [10 -10 20];
assertEqual(testCase, ctrl, pt, 'AbsTol', .01);


function testRotationOxOnMesh(testCase)

vertices = [0 0 0;1 0 0;0 1 0;0 0 1];
faces = [1 2 3;1 2 4;1 3 4;2 3 4];
mesh = struct('vertices', vertices, 'faces', faces);
transfo = createRotationOx([0.5 0.5 0.5], pi/3);

mesh2 = transformPoint3d(mesh, transfo);
ctrl = transformPoint3d(vertices, transfo);

assertTrue(testCase, isstruct(mesh2));
assertEqual(testCase, mesh2.vertices, ctrl, 'AbsTol', .01);

