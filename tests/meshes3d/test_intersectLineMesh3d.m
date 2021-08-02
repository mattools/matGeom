function test_suite = test_intersectLineMesh3d
%TEST_INTERSECTLINEMESH3D  Test case for the file intersectLineMesh3d
%
%   Test case for the file intersectLineMesh3d
%
%   Example
%   test_intersectLineMesh3d
%
%   See also
%    test_intersectPlaneMesh

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2011-12-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);


function test_Cube(testCase) %#ok<*DEFNU>
% Test intersection of lines with cube faces.

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
assertEqual(testCase, 2, size(pts, 1));

% should contains extreme points
p1 = [20 y0 z0];
p2 = [80 y0 z0];
assertTrue(testCase, ismember(p1, pts, 'rows'));
assertTrue(testCase, ismember(p2, pts, 'rows'));


% test with line in y direction
lineOy = [origin 0 1 0];
pts = intersectLineMesh3d(lineOy, v, f);
assertEqual(testCase, 2, size(pts, 1));

% should contains extreme points
p1 = [x0 30 z0];
p2 = [x0 90 z0];
assertTrue(testCase, ismember(p1, pts, 'rows'));
assertTrue(testCase, ismember(p2, pts, 'rows'));


% test with line in z direction
lineOz = [origin 0 0 1];
pts = intersectLineMesh3d(lineOz, v, f);
assertEqual(testCase, 2, size(pts, 1));

% should contains extreme points
p1 = [x0 y0 40];
p2 = [x0 y0 100];
assertTrue(testCase, ismember(p1, pts, 'rows'));
assertTrue(testCase, ismember(p2, pts, 'rows'));


function test_Octahedron_LineX(testCase)

% create the mesh, with coordinates of face centroids equal to +/- 1 
[v, f] = createOctahedron();
v = v * 3;

% create a line intersecting faces with y>0 and z>0
lineOx = [0 1 1  1 0 0];

% compute intersections
pts = intersectLineMesh3d(lineOx, v, f);

% check size
assertEqual(testCase, size(pts, 1), 2);
% check coords
exp = [-1 1 1;1 1 1];
inds = ismember(exp, pts, 'rows');
assertTrue(testCase, all(inds));


function test_Octahedron_MultiLineX(testCase)
% Compute intersection between octahedron and several lines.

% create the mesh, with coordinates of face centroids equal to +/- 1 
[v, f] = createOctahedron();
v = v * 3;

% create a group of horizontal lines
ex = [1 0 0];
lineOx = [0 1 1 ex; 0 -1 1 ex; 0 1 -1 ex; 0 -1 -1 ex];

% compute intersections
pts = intersectLineMesh3d(lineOx, v, f);

% check size
assertEqual(testCase, size(pts, 1), 8);
% check coords
exp = [-1 1 1; 1 1 1; -1 -1 1; 1 -1 1; -1 1 -1; 1 1 -1; -1 -1 -1; 1 -1 -1];
inds = ismember(exp, pts, 'rows');
assertTrue(testCase, all(inds));


function test_Octahedron_MultiLineY(testCase)
% Compute intersection between octahedron and several lines.

% create the mesh, with coordinates of face centroids equal to +/- 1 
[v, f] = createOctahedron();
v = v * 3;

% create a group of horizontal lines
ey = [0 1 0];
lineOy = [1 0 1 ey; -1 0 1 ey; 1 0 -1 ey; -1 0 -1 ey];

% compute intersections
pts = intersectLineMesh3d(lineOy, v, f);

% check size
assertEqual(testCase, size(pts, 1), 8);
% check coords
exp = [-1 1 1; 1 1 1; -1 -1 1; 1 -1 1; -1 1 -1; 1 1 -1; -1 -1 -1; 1 -1 -1];
inds = ismember(exp, pts, 'rows');
assertTrue(testCase, all(inds));


function test_Octahedron_MultiLineZ(testCase)
% Compute intersection between octahedron and several lines.

% create the mesh, with coordinates of face centroids equal to +/- 1 
[v, f] = createOctahedron();
v = v * 3;

% create a group of horizontal lines
ez = [0 0 1];
lineOz = [1 1 0 ez; -1 1 0 ez; 1 -1 0 ez; -1 -1 0 ez];

% compute intersections
pts = intersectLineMesh3d(lineOz, v, f);

% check size
assertEqual(testCase, size(pts, 1), 8);
% check coords
exp = [-1 1 1; 1 1 1; -1 -1 1; 1 -1 1; -1 1 -1; 1 1 -1; -1 -1 -1; 1 -1 -1];
inds = ismember(exp, pts, 'rows');
assertTrue(testCase, all(inds));
