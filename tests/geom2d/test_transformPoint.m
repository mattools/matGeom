function tests = test_transformPoint
% Test suite for the file transformPoint.
%
%   Test suite for the file transformPoint
%
%   Example
%   test_transformPoint
%
%   See also
%     transformPoint

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2026-03-03,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Translation(testCase) %#ok<*DEFNU>
% Test call of function without argument.

pts = [10 10; 100 50; 70 80];
transfo = createTranslation([30 20]);

res = transformPoint(pts, transfo);

exp = [40 30; 130 70; 100 100];
assertEqual(testCase, res, exp);


function test_Rotation90(testCase) %#ok<*DEFNU>
% Test call of function without argument.

pts = [10 10; 100 50; 70 80];
transfo = createRotation(pi/2);

res = transformPoint(pts, transfo);

exp = [-10 10; -50 100; -80 70];
assertEqual(testCase, res, exp, "AbsTol", 0.01);


function test_functionHandle(testCase) %#ok<*DEFNU>
% Test call of function without argument.

pts = [10 10; 100 50; 70 80];
transfo = @(x) [x(:,2)+10 x(:,1)-10];

res = transformPoint(pts, transfo);

exp = [20 0; 60 90; 90 60];
assertEqual(testCase, res, exp, "AbsTol", 0.01);


