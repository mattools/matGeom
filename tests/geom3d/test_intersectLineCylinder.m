function test_suite = test_intersectLineCylinder
%Check parallelity of 2 vectors
%   output = testIsParallel3d(input)
%
%   Example
%   testIsParallel3d
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

function testSimple(testCase) %#ok<*DEFNU>
% vertical cylinder and horizontal line

% def line
p0  = [0 0 0];
v0  = [1 0 0];
line = [p0 v0];

% def cylinder
p1  = [0 -10 0];
p2  = [0 10 0];
R   = 5;
cyl = [p1 p2 R];

pts = intersectLineCylinder(line, cyl);
testCase.assertEqual([-R 0 0;R 0 0], pts, 'AbsTol', .01);

function testShifted(testCase)
% shift everything by vector [1 2 3]

xt = 1; yt = 2; zt = 3;
vect = [xt yt zt];

% cylinder
p1  = [0 -10 0] + vect;
p2  = [0 10 0] + vect;
R   = 5;
%cyl = [(p2-p1) p1 R];
cyl = [p1 p2 R];

% line
p0  = [0 0 0] + vect;
v0  = [1 0 0];
line = [p0 v0];

% compute intersection
pts     = intersectLineCylinder(line, cyl);
ctrl    = [-R 0 0;R 0 0] + repmat(vect, 2, 1);
testCase.assertEqual(ctrl, pts, 'AbsTol', .01);

function testTranslated(testCase)
% shift everything by vector [1 2 3]

trans = createTranslation(1, 2, 3);

% cylinder
p1  = [0 -10 0];
p2  = [0 10 0];
R   = 5;
p1t = transformPoint3d(p1, trans);
p2t = transformPoint3d(p2, trans);
cyl = [p1t p2t R];

% line
p0 = [0 0 0];
v0 = [1 0 0];
line = transformLine3d([p0 v0], trans);

% compute intersection
pts     = intersectLineCylinder(line, cyl);
ctrl    = transformPoint3d([-R 0 0;R 0 0], trans);
testCase.assertEqual(ctrl, pts, 'AbsTol', .01);


function testRotatedOx(testCase)
% shift everything by vector [1 2 3]
Rx = createRotationOx([1 2 3], pi/4);
trans = Rx;

% cylinder
p1  = [0 -1 0];
p2  = [0 1 0];
R   = 5;
p1t = transformPoint3d(p1, trans);
p2t = transformPoint3d(p2, trans);
cyl = [p1t p2t R];

% line
p0 = [0 0 0];
v0 = [1 0 0];
line = transformLine3d([p0 v0], trans);

% compute intersection
pts     = intersectLineCylinder(line, cyl);
ctrl    = transformPoint3d([-R 0 0;R 0 0], trans);
testCase.assertEqual(ctrl, pts, 'AbsTol', .01);

function testRotatedOy(testCase)
% shift everything by vector [1 2 3]

Rx = createRotationOy([0 0 0], pi/4);
trans = Rx;

% cylinder
p1  = [0 -1 0];
p2  = [0 1 0];
R   = 5;
p1t = transformPoint3d(p1, trans);
p2t = transformPoint3d(p2, trans);
cyl = [p1t p2t R];

% line
p0 = [0 0 0];
v0 = [1 0 0];
line = transformLine3d([p0 v0], trans);

% compute intersection
pts     = intersectLineCylinder(line, cyl);
ctrl    = transformPoint3d([-R 0 0;R 0 0], trans);
testCase.assertEqual(ctrl, pts, 'AbsTol', .01);


function testRotatedOxOy(testCase)
% Compose two rotations and check results still apply

center = [1 2 3];
Rx = createRotationOx(center, pi/4);
Ry = createRotationOy(center, pi/6);
trans = Rx*Ry;

% cylinder
p1  = [0 -1 0];
p2  = [0 1 0];
R   = 5;
p1t = transformPoint3d(p1, trans);
p2t = transformPoint3d(p2, trans);
cyl = [p1t p2t R];

% line
p0 = [0 0 0];
v0 = [1 0 0];
line = transformLine3d([p0 v0], trans);

% compute intersection
pts     = intersectLineCylinder(line, cyl);
ctrl    = transformPoint3d([-R 0 0;R 0 0], trans);
testCase.assertEqual(ctrl, pts, 'AbsTol', .01);


function test_TypeInfinite(testCase)
% vertical cylinder and diagonal line

% def line
p0  = [0 0 0];
v0  = [1 0 1];
line = [p0 v0];

% def cylinder
H = 5;
p1  = [0 0 -H];
p2  = [0 0 +H];
R   = 10;
cyl = [p1 p2 R];

% case of infinite cylinder -> two 'classical' intersections
pts = intersectLineCylinder(line, cyl, 'type', 'infinite');
testCase.assertEqual([-R 0 -R;R 0 R], pts, 'AbsTol', .01);

function test_TypeOpen(testCase)
% vertical cylinder and diagonal line

% def line
p0  = [0 0 0];
v0  = [1 0 1];
line = [p0 v0];

% def cylinder
H = 5;
p1  = [0 0 -H];
p2  = [0 0 +H];
R   = 10;
cyl = [p1 p2 R];

% case of open cylinder -> no intersection
pts = intersectLineCylinder(line, cyl, 'type', 'open');
testCase.assertEmpty(pts);


function test_TypeClosed(testCase)
% vertical cylinder and diagonal line

% def line
p0  = [0 0 0];
v0  = [1 0 1];
line = [p0 v0];

% def cylinder
H = 5;
p1  = [0 0 -H];
p2  = [0 0 +H];
R   = 10;
cyl = [p1 p2 R];

% case of open cylinder -> no intersection
pts = intersectLineCylinder(line, cyl, 'type', 'closed');
testCase.assertEqual([-H 0 -H;H 0 H], pts, 'AbsTol', .01);
