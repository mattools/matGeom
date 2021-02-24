function tests = test_isPointOnLine3d
% Test suite for the file isPointOnLine3d.
%
%   Test suite for the file isPointOnLine3d
%
%   Example
%   test_isPointOnLine3d
%
%   See also
%     isPointOnLine3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2021-02-24,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2021 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

point = [10 10 10];
line  = [10 10 10  5 4 3];

b = isPointOnLine3d(point, line);

assertTrue(testCase, b);


function test_ManyPoints(testCase) %#ok<*DEFNU>
% Test call of function without argument.

points = [10 10 10; 15 14 13; 60 50 40; 10 20 30];
line  = [10 10 10  5 4 3];

b = isPointOnLine3d(points, line);

assertEqual(testCase, size(b), [4 1]);
assertEqual(testCase, b, [true; true; true; false]);



function test_ManyPointsManyLines(testCase) %#ok<*DEFNU>
% Expect result to be NP-by-NL.

points = [10 10 10; 15 14 13; 60 50 40; 13 14 15];
lines  = [10 10 10  5 4 3 ; 10 10 10  3 4 5];

b = isPointOnLine3d(points, lines);

assertEqual(testCase, size(b), [4 2]);
exp = logical([1 1 ; 1 0;1 0;0 1]);
assertEqual(testCase, b, exp);


