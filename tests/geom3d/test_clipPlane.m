function tests = test_clipPlane
% Test suite for the file clipPlane.
%
%   Test suite for the file clipPlane
%
%   Example
%   test_clipPlane
%
%   See also
%     clipPlane

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2021-11-09,    using Matlab 9.10.0.1684407 (R2021a) Update 3
% Copyright 2021 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_PlaneXY(testCase) %#ok<*DEFNU>
% Test call of function without argument.

plane = [5 5 5  1 0 0  0 1 0];
bounds = [0 10 0 10 0 10];

poly = clipPlane(plane, bounds);

assertEqual(testCase, [4 3], size(poly));
assertTrue(testCase, ismember([ 0  0 5], poly, 'rows'));
assertTrue(testCase, ismember([10  0 5], poly, 'rows'));
assertTrue(testCase, ismember([ 0 10 5], poly, 'rows'));
assertTrue(testCase, ismember([10 10 5], poly, 'rows'));


function test_PlaneYZ(testCase) %#ok<*DEFNU>
% Test call of function without argument.

plane = [5 5 5  0 1 0  0 0 1];
bounds = [0 10 0 10 0 10];

poly = clipPlane(plane, bounds);

assertEqual(testCase, [4 3], size(poly));
assertTrue(testCase, ismember([ 5  0  0], poly, 'rows'));
assertTrue(testCase, ismember([ 5 10  0], poly, 'rows'));
assertTrue(testCase, ismember([ 5  0 10], poly, 'rows'));
assertTrue(testCase, ismember([ 5 10 10], poly, 'rows'));


function test_PlaneXZ(testCase) %#ok<*DEFNU>
% Test call of function without argument.

plane = [5 5 5  1 0 0  0 0 1];
bounds = [0 10 0 10 0 10];

poly = clipPlane(plane, bounds);

assertEqual(testCase, [4 3], size(poly));
assertTrue(testCase, ismember([ 0  5  0], poly, 'rows'));
assertTrue(testCase, ismember([10  5  0], poly, 'rows'));
assertTrue(testCase, ismember([ 0  5 10], poly, 'rows'));
assertTrue(testCase, ismember([10  5 10], poly, 'rows'));

