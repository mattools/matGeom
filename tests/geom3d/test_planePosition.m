function test_suite = test_planePosition(varargin) %#ok<STOUT>
%TEST_PLANEPOSITION  Test case for the file planePosition
%
%   Test case for the file planePosition

%   Example
%   test_planePosition
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-10-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

initTestSuite;

function test_Simple %#ok<*DEFNU>
% Test call of function with one plane and one point

plane = [10 20 30  1 0 0  0 1 0];
point = [13 24 35];
exp = [3 4];
pos = planePosition(point, plane);
assertElementsAlmostEqual(exp, pos);

function test_NPlanes
%  test case of one point and several planes

plane = [10 20 30  1 0 0  0 1 0];
point = [13 24 35];
exp = repmat([3 4], 5, 1);
pos = planePosition(point, repmat(plane, 5, 1));
assertElementsAlmostEqual(exp, pos);


function test_NPoints
%  test case of one plane and several points

plane = [10 20 30  1 0 0  0 1 0];
point = [13 24 35];
exp = repmat([3 4], 5, 1);
pos = planePosition(repmat(point, 5, 1), plane);
assertElementsAlmostEqual(exp, pos);

function test_NBoth
% test case of two arrays with same number of rows

plane = [10 20 30  1 0 0  0 1 0];
point = [13 24 35];
exp = repmat([3 4], 5, 1);
pos = planePosition(repmat(point, 5, 1), repmat(plane, 5, 1));
assertElementsAlmostEqual(exp, pos);
