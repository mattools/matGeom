function test_suite = test_circumCircle
%TEST_CIRCUMCIRCLE  Test case for the file circumCircle
%
%   Test case for the file circumCircle

%   Example
%   test_circumCircle
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument

p1 = [10 10];
p2 = [50 10];
p3 = [10 50];

circle = circumCircle(p1, p2, p3);

testCase.assertEqual([30 30], circle(1:2), 'AbsTol', .01);
