function test_suite = test_triangleArea
%TEST_TRIANGLEAREA  Test case for the file triangleArea
%
%   Test case for the file triangleArea

%   Example
%   test_triangleArea
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-08-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_CCW_Triangle(testCase) %#ok<*DEFNU>

% rectangle triangle with sides 20 and 30 -> area is 300.
p1 = [10 20];
p2 = [30 20];
p3 = [10 50];

exp = 300;

% run as separate inputs
area = triangleArea(p1, p2, p3);
testCase.assertEqual(exp, area);
area = triangleArea(p2, p3, p1);
testCase.assertEqual(exp, area);
area = triangleArea(p3, p1, p2);
testCase.assertEqual(exp, area);

% run as bundled array
area = triangleArea([p1; p2; p3]);
testCase.assertEqual(exp, area);

function test_CW_Triangle(testCase)

% rectangle triangle with sides 20 and 30 -> area is 300.
p1 = [10 20];
p2 = [30 20];
p3 = [10 50];

exp = -300;

% run as separate inputs
area = triangleArea(p3, p2, p1);
testCase.assertEqual(exp, area);
area = triangleArea(p1, p3, p2);
testCase.assertEqual(exp, area);
area = triangleArea(p2, p1, p3);
testCase.assertEqual(exp, area);

% run as bundled array
area = triangleArea([p3; p2; p1]);
testCase.assertEqual(exp, area);

