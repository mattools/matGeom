function tests = test_intersectEdgePolygon3d
% Test suite for the file intersectEdgePolygon3d.
%
%   Test suite for the file intersectEdgePolygon3d
%
%   Example
%   test_intersectEdgePolygon3d
%
%   See also
%     intersectEdgePolygon3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2021-02-24,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2021 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test computation for one edge and one polygon

% Compute intersection between a 3D edge and a 3D triangle
pts3d = [3 0 0; 0 6 0;0 0 9];
edge1 = [0 0 0 3 6 9];

inter = intersectEdgePolygon3d(edge1, pts3d);

assertEqual(testCase, size(inter), [1 3]);
assertEqual(testCase, inter, [1 2 3]);


function test_TwoEdges(testCase) %#ok<*DEFNU>
% Test computation for two edges

pts3d = [3 0 0; 0 6 0;0 0 9];
edges = [0 0 0 3 6 9;10 0 0 10 2 3];

[inter, inside] = intersectEdgePolygon3d(edges, pts3d);

assertEqual(testCase, size(inter), [2 3]);
assertEqual(testCase, size(inside), [2 1]);
assertEqual(testCase, inside, [true ; false]);
assertEqual(testCase, inter(inside, :), [1 2 3]);
