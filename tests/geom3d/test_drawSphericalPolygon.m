function tests = test_drawSphericalPolygon
% Test suite for the file drawSphericalPolygon.
%
%   Test suite for the file drawSphericalPolygon
%
%   Example
%   test_drawSphericalPolygon
%
%   See also
%     drawSphericalPolygon

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
p3 = [-1 0 1];
p4 = [-1 -1 1];
p5 = [-1 -1 0];
poly = [p1 ; p2 ; p3;p4;p5];
hFig = figure; hold on;

h = drawSphericalPolygon([0 0 0 1], poly, 'LineWidth', 2);
assertTrue(testCase, all(ishandle(h)));

close(hFig);


