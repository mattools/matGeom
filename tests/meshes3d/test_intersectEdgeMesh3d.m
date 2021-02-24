function tests = test_intersectEdgeMesh3d
% Test suite for the file intersectEdgeMesh3d.
%
%   Test suite for the file intersectEdgeMesh3d
%
%   Example
%   test_intersectEdgeMesh3d
%
%   See also
%     intersectEdgeMesh3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2021-02-24,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2021 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

[V, F] = createCube;
edge = [-1 0.3 0.4  +3 0.3 0.4];

pts = intersectEdgeMesh3d(edge, V, F);

assertEqual(testCase, size(pts), [2 3]);
assertEqual(testCase, pts, [1 0.3 0.4 ; 0 0.3 0.4], 'AbsTol', .01);
