function tests = test_drawDome
% Test suite for the file drawDome.
%
%   Test suite for the file drawDome
%
%   Example
%   test_drawDome
%
%   See also
%     drawDome

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-10,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hFig = figure;

h = drawDome([0 1 0 1], [0 1 0]);

assertTrue(testCase, all(ishghandle(h)));

close(hFig);
