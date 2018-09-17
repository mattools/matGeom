function test_suite = test_isLeftOriented
% One-line description here, please.
%   output = test_isLeftOriented(input)
%
%   Example
%   test_isLeftOriented
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_HorizLeft(testCase) %#ok<*DEFNU>

line = [10 20 3 0];
p1 = [15 25];

testCase.assertTrue(isLeftOriented(p1, line));


function test_HorizRight(testCase) %#ok<*DEFNU>

line = [10 20 3 0];
p1 = [15 5];

testCase.assertFalse(isLeftOriented(p1, line));


function test_PointArray(testCase) %#ok<*DEFNU>

% one line, three points
line = [10 20 3 0];
pts = [15 25; 15 15; 15 05];

% expect 3-by-1 array
exp = [true; false; false];
testCase.assertEqual(exp, isLeftOriented(pts, line));


function test_LineArray(testCase)

% four lines, one point
lines = [....
    10 10 3 0; ...  % left
    10 10 0 3; ...  % right
    10 10 1.5 1.5; ...  % left
    10 10 1.5 -1.5; ... % left
];    
pt = [21.1 32.2];

% expect 1-by-4 array
exp = [true false true true];

testCase.assertEqual(exp, isLeftOriented(pt, lines));
