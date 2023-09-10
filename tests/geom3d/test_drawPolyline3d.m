function tests = test_drawPolyline3d
% Test suite for the file drawPolyline3d.
%
%   Test suite for the file drawPolyline3d
%
%   Example
%   test_drawPolyline3d
%
%   See also
%     drawPolyline3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-10,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hf = figure();

t = linspace(0, 2*pi, 9)';
xt = 10 * cos(t);
yt = 5 * sin(t);
zt = zeros(size(xt));
poly = [xt yt zt];

hp = drawPolyline3d(poly, 'linewidth', 2, 'color', 'k');

assertTrue(testCase, ishghandle(hp));

close(hf);


function test_cellArray(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hf = figure();

poly = {...
    [10 10 10;20 10 10;20 20 10;10 20 10], ...
    [10 10 20;20 10 20;20 20 20;10 20 20], ...
    };

hp = drawPolyline3d(poly, 'linewidth', 2, 'color', 'k');

assertTrue(testCase, all(ishghandle(hp)));
assertEqual(testCase, length(hp), 2);

close(hf);
