function tests = test_isPointOnEdge3d
% Test suite for the file isPointOnEdge3d.
%
%   Test suite for the file isPointOnEdge3d
%
%   Example
%   test_isPointOnEdge3d
%
%   See also
%     isPointOnEdge3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2021-02-24,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2021 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);


function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

point = [10 10 10];
edge  = [10 10 10  15 14 13];

b = isPointOnEdge3d(point, edge);

assertTrue(testCase, b);


function test_ManyPoints(testCase) %#ok<*DEFNU>
% Test call of function without argument.

points = [10 10 10; 15 14 13; 60 50 40; 10 20 30];
line  = [10 10 10  60 50 40];

b = isPointOnEdge3d(points, line);

assertEqual(testCase, size(b), [4 1]);
assertEqual(testCase, b, [true; true; true; false]);



function test_ManyPointsManyLines(testCase) %#ok<*DEFNU>
% Expect result to be NP-by-NL.

points = [10 10 10; 15 14 13; 60 50 40; 13 14 15];
edges  = [10 10 10  60 50 40 ; 10 10 10  40 50 60];

b = isPointOnEdge3d(points, edges);

assertEqual(testCase, size(b), [4 2]);
exp = logical([1 1 ; 1 0;1 0;0 1]);
assertEqual(testCase, b, exp);




