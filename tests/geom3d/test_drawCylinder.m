function tests = test_drawCylinder
% Test suite for the file drawCylinder.
%
%   Test suite for the file drawCylinder
%
%   Example
%   test_drawCylinder
%
%   See also
%     drawCylinder

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-10,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hFig = figure;

h = drawCylinder([0 0 0 10 20 30 5]);

assertTrue(testCase, all(ishghandle(h)));

close(hFig);

