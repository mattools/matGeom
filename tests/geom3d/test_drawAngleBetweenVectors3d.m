function tests = test_drawAngleBetweenVectors3d
% Test suite for the file drawAngleBetweenVectors3d.
%
%   Test suite for the file drawAngleBetweenVectors3d
%
%   Example
%   test_drawAngleBetweenVectors3d
%
%   See also
%     drawAngleBetweenVectors3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-10,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hFig = figure;

h = drawAngleBetweenVectors3d([0 0 0], [1 0 0], [0 1 0], 0.5);

assertTrue(testCase, all(ishghandle(h)));

close(hFig);
