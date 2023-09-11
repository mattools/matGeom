function tests = test_drawPlane
% Test suite for the file drawPlane.
%
%   Test suite for the file drawPlane
%
%   Example
%   test_drawPlane
%
%   See also
%     drawPlane

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-10,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_xyPlane(testCase) %#ok<*DEFNU>
% Test call of function without argument.

plane = [1 2 3  1 0 0  0 1 0];
hf = figure; axis([-10 10 -10 10 -10 10]); hold on; view(3);

hp = drawPlane3d(plane);

assertTrue(testCase, ishghandle(hp));

close(hf);


function test_multiplePlanes(testCase) %#ok<*DEFNU>
% Test call of function without argument.

plane = [...
    1 2 3  1 0 0  0 1 0; ...
    1 2 3  1 0 0  0 0 1; ...
    1 2 3  0 1 0  0 0 1; ...
    ];
hf = figure; axis([-10 10 -10 10 -10 10]); hold on; view(3);

hp = drawPlane3d(plane);

assertEqual(testCase, length(hp), 3);
assertTrue(testCase, all(ishghandle(hp)));

close(hf);

