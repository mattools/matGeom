function tests = test_meshVertexRing
% Test suite for the file meshVertexRing.
%
%   Test suite for the file meshVertexRing
%
%   Example
%   test_meshVertexRing
%
%   See also
%     meshVertexRing

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2024-05-27,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2024 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_ico2_sixNeighbors(testCase) %#ok<*DEFNU>
% Test call of function without argument.

mesh = subdivideMesh(createIcosahedron, 2);
inds = meshVertexRing(mesh, 41);

assertEqual(testCase, length(inds), 6);

function test_ico2_fiveNeighbors(testCase) %#ok<*DEFNU>
% Test call of function without argument.

mesh = subdivideMesh(createIcosahedron, 2);
inds = meshVertexRing(mesh, 10);

assertEqual(testCase, length(inds), 5);


