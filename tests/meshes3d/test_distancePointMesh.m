function test_suite = test_distancePointMesh
%TEST_DISTANCEPOINTTRIMESH  One-line description here, please.
%
%   output = test_distancePointMesh(input)
%
%   Example
%   test_distancePointMesh
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2018-03-08,    using Matlab 9.3.0.713579 (R2017b)
% Copyright 2018 INRA - Cepia Software Platform.

% corps du fichier contenant la suite de tests

% testSuite = buildFunctionHandleTestSuite(localfunctions);
test_suite = functiontests(localfunctions);


function testTetraedron(testCase) %#ok<*DEFNU>

[v, f] = createOctahedron;

testCase.assertEqual(1, distancePointMesh([2 0 0], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([0 2 0], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([0 0 2], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([-2 0 0], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([0 -2 0], v, f), .0001);
testCase.assertEqual(1, distancePointMesh([0 0 -2], v, f), .0001);

exp = sqrt(2) / 2;
testCase.assertEqual(exp, distancePointMesh([1 1 0], v, f), .0001);
testCase.assertEqual(exp, distancePointMesh([1 0 1], v, f), .0001);
testCase.assertEqual(exp, distancePointMesh([0 1 1], v, f), .0001);


function testSingleTriangle(testCase) 

v = [10 10 10 ; 20 10 10 ; 10 20 10];
f = [1 2 3];

% around lower left corner
testCase.assertEqual(2, distancePointMesh([ 10  8 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([  8 10 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([ 12  8 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([  8 12 10 ], v, f), .0001);
testCase.assertEqual(2*sqrt(2), distancePointMesh([  8  8 10 ], v, f), .0001);
% more around lower left corner
testCase.assertEqual(sqrt(5), distancePointMesh([  8  9 10 ], v, f), .0001);
testCase.assertEqual(sqrt(5), distancePointMesh([  9  8 10 ], v, f), .0001);

% around right corner
testCase.assertEqual(2, distancePointMesh([ 20  8 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([ 18  8 10 ], v, f), .0001);
testCase.assertEqual(2, distancePointMesh([ 22 10 10 ], v, f), .0001);
testCase.assertEqual(2*sqrt(2), distancePointMesh([ 22  8 10 ], v, f), .0001);
testCase.assertEqual(sqrt(5), distancePointMesh([ 22  9 10 ], v, f), .0001);

% around top left corner
testCase.assertEqual(sqrt(5), distancePointMesh([  9 22 10 ], v, f), .0001);


function test_ortho_diag(testCase)
% bug found when updating distancePointMesh function
%
% mesh is a single face, query point is above the largest side of the
% triangle. 
v = [0 0 0; 10 0 0; 0 10 0];
f = [1 2 3];
point111 = [11 1 0];
d = distancePointMesh(point111, v, f, 'algorithm', 'vectorized');
testCase.assertEqual(sqrt(2), d, 0.0001);

function testSingleTriangleAllSubregions(testCase)
% The algorithm described in "David Eberly, 'Distance Between Point and 
% Triangle in 3D', Geometric Tools, LLC, (1999)" splits the plane of the
% triangle into region 0 to 6. The regions here are not numbered as in the
% original paper of D. Eberly but as in distancePointTrimesh_vectorized.
%
%        /\ t
%        |
%   \ R5 |
%    \   |
%     \  |
%      \ |
%       \| P3
%        *
%        |\
%        | \
%   R1   |  \   R4
%        |   \
%        | R0 \ 
%        |     \ 
%        | P1   \ P2
%  ------*-------*------> s
%        |        \   
%   R3   |   R2    \   R6 
%
% In the code the regions split into subregions. The regions over the
% vertices into 5, some of which only occur if the vertex has an abuse
% angle. The regions over edges split into 3 subregions, some of which
% only occur if the neighbouring vertices have acute angles.
% The following code uses triangle and one set of test points and
% switches the vertex numbers, so that every subcase is tested.

v = [36 20 10; 40 20 10; 30 30 10];

% The regions for the testPoints in the comment apply for faces = [1 2 3].
% For faces = [2 3 1] R3 becomes R5 and R4 becomes R2.
% For faces = [3 1 2] R3 becomes R6 and R4 becomes R1.
% Also the terms for the subcases change, but still all subcases are
% tested.
testPoints = [36 22 10; %R0
    42 5 10; %R3 (d<0 & a<=d)
    38 5 10; %R3 (d<0 & a>d)
    30 5 10; %R3 (d>=0 & e>=0)
    5 18 10; %R3 (d>=0 & c<=-e)
    13 13 10; %R3 (c>-e & e<0)
    30 40 10; %R4 ((c+e)-(b+d)<=0)
    50 25 10; %R4 ((c+e)-(b+d)>=a-2*b+c)
    40 30 10]; %R4 ((c+e)-(b+d)>0 & (c+e)-(b+d)<a-2*b+c)

projResults = [36 22 10;
    40 20 10;
    38 20 10;
    36 20 10;
    30 30 10;
    33 25 10;
    30 30 10;
    40 20 10;
    35 25 10];

f = [1 2 3];

[dist_s, proj_s] = distancePointMesh(testPoints, v, f, 'algorithm', 'sequential');
testCase.assertEqual(proj_s, projResults, 'AbsTol', 1e-6)
[dist_v, proj_v] = distancePointMesh(testPoints, v, f, 'algorithm', 'vectorized');
testCase.assertEqual(proj_v, projResults, 'AbsTol', 1e-6)

f = [2 3 1];

[dist_s, proj_s] = distancePointMesh(testPoints, v, f, 'algorithm', 'sequential');
testCase.assertEqual(proj_s, projResults, 'AbsTol', 1e-6)
[dist_v, proj_v] = distancePointMesh(testPoints, v, f, 'algorithm', 'vectorized');
testCase.assertEqual(proj_v, projResults, 'AbsTol', 1e-6)

f = [3 1 2];

[dist_s, proj_s] = distancePointMesh(testPoints, v, f, 'algorithm', 'sequential');
testCase.assertEqual(proj_s, projResults, 'AbsTol', 1e-6)
[dist_v, proj_v] = distancePointMesh(testPoints, v, f, 'algorithm', 'vectorized');
testCase.assertEqual(proj_v, projResults, 'AbsTol', 1e-6)
