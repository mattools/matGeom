function tests = test_subdivideMeshEdges
% Test suite for the file subdivideMeshEdges.
%
%   Test suite for the file subdivideMeshEdges
%
%   Example
%   test_subdivideMeshEdges
%
%   See also
%     subdivideMeshEdges

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2026-03-03,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Tetrahedron(testCase) %#ok<*DEFNU>
% Test call of function without argument.

tet = createTetrahedron;

tet2 = subdivideMeshEdges(tet, 4);

% 4 + 6*3
assertEqual(testCase, size(tet2.vertices, 1), 22);
assertEqual(testCase, size(tet2.faces, 1), 4);
assertEqual(testCase, size(tet2.faces, 2), 12);


function test_Cube(testCase) %#ok<*DEFNU>
% Test call of function without argument.

cube = createCube;

cube2 = subdivideMeshEdges(cube, 3);

% 8 + 12*2 = 32
assertEqual(testCase, size(cube2.vertices, 1), 32);
assertEqual(testCase, size(cube2.faces, 1), 6);
% 4 + 4*2 = 12
assertEqual(testCase, size(cube2.faces, 2), 12);
