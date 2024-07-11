function tests = test_line3dPoint
% Test suite for the file line3dPoint.
%
%   Test suite for the file line3dPoint
%
%   Example
%   test_line3dPoint
%
%   See also
%     line3dPoint

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2024-07-11,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

line = createLine3d([10 20 30], [30 90 60]);
point = line3dPoint(line, 0.7);
pos = line3dPosition(point, line);

assertEqual(testCase, pos, 0.7, 'AbsTol', 0.01);


