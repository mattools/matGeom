function tests = test_linePoint
% Test suite for the file linePoint.
%
%   Test suite for the file linePoint
%
%   Example
%   test_linePoint
%
%   See also
%     linePoint

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2024-07-11,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

line = createLine([10 30], [30 90]);
point = linePoint(line, 0.7);
pos = linePosition(point, line);

assertEqual(testCase, pos, 0.7, 'AbsTol', 0.01);


