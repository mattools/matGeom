function tests = test_createPlane
% Test suite for the file createPlane.
%
%   Test suite for the file createPlane
%
%   Example
%   test_createPlane
%
%   See also
%     createPlane

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-12-19,    using Matlab 23.2.0.2409890 (R2023b) Update 3
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);


function test_ThreePoints(testCase) %#ok<*DEFNU>
% Test creation from three points.

p1 = [1 1 3];
p2 = [4 3 3];
p3 = [2 4 3];

plane = createPlane(p1, p2, p3);

normal = [0 0 1];
assertEqual(testCase, planeNormal(plane), normal, 'AbsTol', 0.01);


function test_ThreePointsArray(testCase) %#ok<*DEFNU>
% Test creation from three points.

p1 = [1 1 3];
p2 = [4 3 3];
p3 = [2 4 3];

plane = createPlane([p1 ; p2 ; p3]);

normal = [0 0 1];
assertEqual(testCase, planeNormal(plane), normal, 'AbsTol', 0.01);


function test_PointNormal(testCase) %#ok<*DEFNU>
% Test creation from origin and normal.

origin = [3 2 1];
normal = [0 0 1];

plane = createPlane(origin, normal);

assertEqual(testCase, planeNormal(plane), normal, 'AbsTol', 0.01);

