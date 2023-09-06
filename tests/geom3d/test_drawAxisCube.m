function tests = test_drawAxisCube
% Test suite for the file drawAxisCube.
%
%   Test suite for the file drawAxisCube
%
%   Example
%   test_drawAxisCube
%
%   See also
%     drawAxisCube

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-06,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Empty(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hf = 101;
figure(hf); clf;

ha = drawAxisCube;

assertTrue(testCase, ishghandle(ha));

close(hf);

