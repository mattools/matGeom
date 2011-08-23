function test_suite = test_triangleArea(varargin) %#ok<STOUT>
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

initTestSuite;

function test_Simple %#ok<*DEFNU>
% Test call of function without argument

% rectangle triangle with sides 20 and 30 -> area is 300.
p1 = [10 20];
p2 = [30 20];
p3 = [10 50];

exp = 300;

area = triangleArea(p1, p2, p3);
assertEqual(exp, area);
area = triangleArea(p2, p3, p1);
assertEqual(exp, area);
area = triangleArea(p3, p1, p2);
assertEqual(exp, area);

area = triangleArea(p3, p2, p1);
assertEqual(exp, area);
area = triangleArea(p1, p3, p2);
assertEqual(exp, area);
area = triangleArea(p2, p1, p3);
assertEqual(exp, area);

area = triangleArea([p1; p2; p3]);
assertEqual(exp, area);

