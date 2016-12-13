function test_suite = test_intersectLineMesh3d
%TEST_INTERSECTLINEMESH3D  Test case for the file intersectLineMesh3d
%
%   Test case for the file intersectLineMesh3d

%   Example
%   test_intersectLineMesh3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);


function test_Cube(testCase) %#ok<*DEFNU>
% Test call of function without argument

% position of origin
x0 = 20+10;
y0 = 30+20;
z0 = 40+30;
origin = [x0 y0 z0];
    
% create a cube
[v, f] = createCube();
v = transformPoint3d(v*60, createTranslation3d([20 30 40]));
f = triangulateFaces(f);


% test with horizontal line
lineOx = [origin 1 0 0];
pts = intersectLineMesh3d(lineOx, v, f);
testCase.assertEqual(2, size(pts, 1));

% should contains extreme points
p1 = [20 y0 z0];
p2 = [80 y0 z0];
testCase.assertTrue(ismember(p1, pts, 'rows'));
testCase.assertTrue(ismember(p2, pts, 'rows'));


% test with line in y direction
lineOy = [origin 0 1 0];
pts = intersectLineMesh3d(lineOy, v, f);
testCase.assertEqual(2, size(pts, 1));

% should contains extreme points
p1 = [x0 30 z0];
p2 = [x0 90 z0];
testCase.assertTrue(ismember(p1, pts, 'rows'));
testCase.assertTrue(ismember(p2, pts, 'rows'));


% test with line in z direction
lineOz = [origin 0 0 1];
pts = intersectLineMesh3d(lineOz, v, f);
testCase.assertEqual(2, size(pts, 1));

% should contains extreme points
p1 = [x0 y0 40];
p2 = [x0 y0 100];
testCase.assertTrue(ismember(p1, pts, 'rows'));
testCase.assertTrue(ismember(p2, pts, 'rows'));

