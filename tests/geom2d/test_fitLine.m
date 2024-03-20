function tests = test_fitLine
% Test suite for the file fitLine.
%
%   Test suite for the file fitLine
%
%   Example
%   test_fitLine
%
%   See also
%     fitLine

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-04-04,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

% generate points aligned along a line
rng(42);
lx = -10:0.2:10;
ly = 0.75 * lx + 2.5 + rand(size(lx));
pts = [lx(:) ly(:)];

line = fitLine(pts);

coeff = line(4) / line(3);
assertEqual(testCase, coeff, 0.75, 'AbsTol', 0.1);


