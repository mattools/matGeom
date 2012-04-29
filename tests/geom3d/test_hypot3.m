function test_suite = test_hypot3(varargin) %#ok<STOUT>
%TEST_HYPOT3  Test case for the file hypot3
%
%   Test case for the file hypot3

%   Example
%   test_hypot3
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-04-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

initTestSuite;

function test_UnitCube %#ok<*DEFNU>
% Test call of function without argument
h = hypot3(1, 1, 1);
exp = sqrt(3);
assertAlmostEqual(exp, h);

function test_Cuboid345

exp = sqrt(50);
h = hypot3(3, 4, 5);
assertAlmostEqual(exp, h);


