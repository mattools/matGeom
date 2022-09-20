function tests = test_drawSphericalEdge
% Test suite for the file drawSphericalEdge.
%
%   Test suite for the file drawSphericalEdge
%
%   Example
%   test_drawSphericalEdge
%
%   See also
%     drawSphericalEdge

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2022-09-20,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2022 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.


p1 = [0 -1 0];
p2 = [0 0 1];
hFig = figure;

h = drawSphericalEdge([0 0 0 1], [p1 p2], 'LineWidth', 2);
assertTrue(testCase, ishandle(h));

close(hFig);

