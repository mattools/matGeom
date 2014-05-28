function test_suite = test_anglePoints3d(varargin) %#ok<STOUT>
%TEST_ANGLEPOINTS3D  Test case for the file anglePoints3d
%
%   Test case for the file anglePoints3d

%   Example
%   test_anglePoints3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-05-28,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.

initTestSuite;

function test_Simple %#ok<*DEFNU>
% Test call of function without argument
origin = [0 0 0];
p1 = [5 0 0];
p2 = [0 3 0];
p3 = [0 0 4];
exp = pi/2;

res = anglePoints3d(p1, origin, p2);
assertAlmostEqual(exp, res, .01);

res = anglePoints3d(p1, origin, p3);
assertAlmostEqual(exp, res, .01);

res = anglePoints3d(p2, origin, p3);
assertAlmostEqual(exp, res, .01);


function test_Simple2
% Test call of function without argument
origin = [0 0 0];
p1 = [3 3 0];
p2 = [10 0 0];
exp = pi/4;

res = anglePoints3d(p1, origin, p2);

assertAlmostEqual(exp, res, .01);


function test_Point2Array
% Test call of function without argument
p1 = [0 0 0];
p2 = zeros(5, 3);
p2(:,1) = 5;
p2(:,2) = -2:2;
p3 = [10 0 0];

res = anglePoints3d(p1, p2, p3);
assertAlmostEqual([5 1], size(res));

