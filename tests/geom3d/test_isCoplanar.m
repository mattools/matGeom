function test_suite = test_isCoplanar
%TEST_ISCOPLANAR  Test case for the file isCoplanar
%
%   Test case for the file isCoplanar
%
%   Example
%   test_isCoplanar
%
%   See also
%   isCoplanar

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-03-15,    using Matlab 9.5.0.944444 (R2018b)
% Copyright 2019 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_PlaneXY(testCase) %#ok<*DEFNU>
% Test call of function without argument

p1 = [ 0  0 10];
p2 = [10  0 10];
p3 = [10 10 10];
p4 = [ 0 10 10];

b = isCoplanar([p1; p2; p3; p4], 1e-10);
testCase.assertTrue(b);

p4 = [ 0 10 11];

testCase.assertTrue(~isCoplanar([p1; p2; p3; p4], 1e-10));


function test_PlaneXZ(testCase) %#ok<*DEFNU>
% Test call of function without argument

p1 = [ 0 10  0];
p2 = [10 10  0];
p3 = [10 10 10];
p4 = [ 0 10 10];

b = isCoplanar([p1; p2; p3; p4], 1e-10);
testCase.assertTrue(b);

p4 = [ 0 11 10];

testCase.assertTrue(~isCoplanar([p1; p2; p3; p4], 1e-10));

function test_PlaneYZ(testCase) %#ok<*DEFNU>
% Test call of function without argument

p1 = [10  0  0];
p2 = [10 10  0];
p3 = [10 10 10];
p4 = [10  0 10];

b = isCoplanar([p1; p2; p3; p4], 1e-10);
testCase.assertTrue(b);

p4 = [11  0 10];

testCase.assertTrue(~isCoplanar([p1; p2; p3; p4], 1e-10));
