function test_suite = test_triangleArea3d(varargin) %#ok<STOUT>
%TEST_TRIANGLEAREA3D  Test case for the file triangleArea3d
%
%   Test case for the file triangleArea3d

%   Example
%   test_triangleArea3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-08-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function test_Simple %#ok<*DEFNU>

% rectangle triangle with sides 20 and 30 -> area is 300.
p1 = [10 20 30];
p2 = [30 20 30];
p3 = [10 50 30];

exp = 300;

area = triangleArea3d(p1, p2, p3);
assertEqual(exp, area);
area = triangleArea3d(p2, p3, p1);
assertEqual(exp, area);
area = triangleArea3d(p3, p1, p2);
assertEqual(exp, area);

area = triangleArea3d(p3, p2, p1);
assertEqual(exp, area);
area = triangleArea3d(p1, p3, p2);
assertEqual(exp, area);
area = triangleArea3d(p2, p1, p3);
assertEqual(exp, area);

area = triangleArea3d([p1; p2; p3]);
assertEqual(exp, area);


function test_XZ

% rectangle triangle with sides 20 and 30 -> area is 300.
p1 = [10 30 20];
p2 = [30 30 20];
p3 = [10 30 50];
exp = 300;

area = triangleArea3d(p1, p2, p3);
assertEqual(exp, area);

area = triangleArea3d([p1; p2; p3]);
assertEqual(exp, area);

function test_YZ

% rectangle triangle with sides 20 and 30 -> area is 300.
p1 = [30 10 20];
p2 = [30 30 20];
p3 = [30 10 50];
exp = 300;

area = triangleArea3d(p1, p2, p3);
assertEqual(exp, area);

area = triangleArea3d([p1; p2; p3]);
assertEqual(exp, area);

