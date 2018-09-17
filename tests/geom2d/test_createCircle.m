function test_suite = test_createCircle
% One-line description here, please.
%   output = testMidPoint(input)
%
%   Example
%   testMidPoint
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_threePoints(testCase) %#ok<*DEFNU>

p1 = [10 15];
p2 = [15 20];
p3 = [10 25];
exp = [10 20 5];

circle = createCircle(p1, p2, p3);
testCase.assertEqual(exp, circle, 'AbsTol', .01);

circle = createCircle(p3, p1, p2);
testCase.assertEqual(exp, circle, 'AbsTol', .01);

circle = createCircle(p2, p3, p1);
testCase.assertEqual(exp, circle, 'AbsTol', .01);


function test_threeArrays(testCase) %#ok<*DEFNU>

p1 = [10 15];
p2 = [15 20];
p3 = [10 25];
exp = [10 20 5];

p1 = [p1; p1+10; p1+20; p1-5];
p2 = [p2; p2+10; p2+20; p2-5];
p3 = [p3; p3+10; p3+20; p3-5];

exp = repmat(exp, 4, 1) + [0 0 0;10 10 0;20 20 0;-5 -5 0];

circle = createCircle(p1, p2, p3);
testCase.assertEqual(exp, circle, 'AbsTol', .01);

circle = createCircle(p3, p1, p2);
testCase.assertEqual(exp, circle, 'AbsTol', .01);

circle = createCircle(p2, p3, p1);
testCase.assertEqual(exp, circle, 'AbsTol', .01);
