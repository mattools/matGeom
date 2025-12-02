function tests = test_intersectConvexPolyhedra
% Test suite for the file intersectConvexPolyhedra.
%
%   Test suite for the file intersectConvexPolyhedra
%
%   Example
%   test_intersectConvexPolyhedra
%
%   See also
%     intersectConvexPolyhedra

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2025-12-01,    using Matlab 25.1.0.2943329 (R2025a)
% Copyright 2025 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_twoOctahedra(testCase) %#ok<*DEFNU>
% Test call of function without argument.

% create a cubic mesh with corners at +/- 1
mesh1 = createCube;
mesh1.vertices = (mesh1.vertices - mean(mesh1.vertices)) * 2;
transfo = createTranslation3d([1.0 0 0]);
mesh2 = transformMesh(createOctahedron, transfo);

res = intersectConvexPolyhedra(mesh1, mesh2);

% pyramid with square basis -> four triangle faces for sides, plus two for basis
assertEqual(testCase, size(res.vertices), [5 3]);
assertEqual(testCase, size(res.faces), [6 3]);


