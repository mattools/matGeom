function tests = test_isPointInEllipsoid
% Test suite for the file isPointInEllipsoid.
%
%   Test suite for the file isPointInEllipsoid
%
%   Example
%   test_isPointInEllipsoid
%
%   See also
%     isPointInEllipsoid

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2020-11-20,    using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Inside(testCase) %#ok<*DEFNU>
% Test call of function without argument.

elli = [10 20 30   50 30 10   5 10 0];
p = [20 30 35];

b = isPointInEllipsoid(p, elli);

assertTrue(testCase, b);


function test_Outside(testCase) %#ok<*DEFNU>
% Test call of function without argument.

elli = [10 20 30   50 30 10   5 10 0];
p = [-20 10 25];

b = isPointInEllipsoid(p, elli);

assertFalse(testCase, b);


