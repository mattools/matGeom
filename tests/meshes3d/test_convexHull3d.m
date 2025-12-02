function tests = test_convexHull3d
% Test suite for the file convexHull3d.
%
%   Test suite for the file convexHull3d
%
%   Example
%   test_convexHull3d
%
%   See also
%     convexHull3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2025-12-02,    using Matlab 25.1.0.2943329 (R2025a)
% Copyright 2025 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_tetrahedron(testCase) %#ok<*DEFNU>
% Test call of function without argument.

pts = [-1 -1 -1; 1 1 -1; 1 -1 1; -1 1 1];

res = convexHull3d(pts);

assertTrue(testCase, isstruct(res));
assertEqual(testCase, size(res.vertices), [4 3]);
assertEqual(testCase, size(res.faces), [4 3]);


function test_octahedronWithPointsInside(testCase) %#ok<*DEFNU>
% Test call of function without argument.

pts = [...
    -1 0 0; 1 0 0;0 -1 0;0 1 0;0 0 -1;0 0 1; ...
    -0.5 0 0; 0.1 0.2 0.3; -0.3 -0.1 0.2; 0.2 -0.1 0.3; ...
    0.2 -0.3 0.1; 0.3 0.2 -0.1;0.1 0.1 0.2; 0.4 -0.1 0.2; ...
];

res = convexHull3d(pts);

assertTrue(testCase, isstruct(res));
assertEqual(testCase, size(res.vertices), [6 3]);
assertEqual(testCase, size(res.faces), [8 3]);


function test_octahedron_splitOutput(testCase) %#ok<*DEFNU>
% Test call of function without argument.

pts = [...
    -1 0 0; 1 0 0;0 -1 0;0 1 0;0 0 -1;0 0 1; ...
    -0.5 0 0; 0.1 0.2 0.3; -0.3 -0.1 0.2; 0.2 -0.1 0.3; ...
    0.2 -0.3 0.1; 0.3 0.2 -0.1;0.1 0.1 0.2; 0.4 -0.1 0.2; ...
];

[v, f] = convexHull3d(pts);

assertTrue(testCase, isnumeric(v));
assertEqual(testCase, size(v), [6 3]);
assertTrue(testCase, isnumeric(f));
assertEqual(testCase, size(f), [8 3]);


function test_cube_mergeCoplanarFaces(testCase) %#ok<*DEFNU>
% Test call of function without argument.

pts = [...
    0 0 0;10 0 0;0 10 0;10 10 0;...
    0 0 10;10 0 10;0 10 10;10 10 10;...
    ];

res = convexHull3d(pts, 'mergeCoplanarFaces', true);

assertTrue(testCase, isstruct(res));
assertTrue(testCase, isnumeric(res.vertices));
assertEqual(testCase, size(res.vertices), [8 3]);
assertTrue(testCase, iscell(res.faces));
assertEqual(testCase, size(res.faces), [6 1]);

