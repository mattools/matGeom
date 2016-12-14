function test_suite = test_midPoint3d
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

function test_twoPoints(testCase) %#ok<*DEFNU>

p1 = [10 20 30];
p2 = [30 40 50];
exp = [20 30 40];
mid = midPoint3d(p1, p2);
testCase.assertEqual(exp, mid);


function test_twoPointArrays(testCase)

p1 = [ ...
    10 20 30; ...
    30 40 50; ...
    50 60 70; ...
    ];
p2 = [ ...
    30 40 50; ...
    50 60 70; ...
    70 80 90];
exp = [...
    20 30 40; ...
    40 50 60; ...
    60 70 80];

mid = midPoint3d(p1, p2);
testCase.assertEqual(exp, mid);

function test_pointArray(testCase)

p1 = [30 40 50];
p2 = [ ...
    30 40 50; ...
    50 60 70; ...
    70 80 90];
exp = [...
    30 40 50; ...
    40 50 60; ...
    50 60 70];

mid = midPoint3d(p1, p2);
testCase.assertEqual(exp, mid);

function test_arrayPoint(testCase)

p1 = [ ...
    10 20 30; ...
    30 40 50; ...
    50 60 70; ...
    ];
p2 = [30 40 50];
exp = [...
    20 30 40; ...
    30 40 50; ...
    40 50 60];

mid = midPoint3d(p1, p2);
testCase.assertEqual(exp, mid);


function test_returnThreeOutputs(testCase)

p1 = [ ...
    10 20 30; ...
    30 40 50; ...
    50 60 70; ...
    ];
p2 = [30 40 50];

expX = [20 ; 30 ; 40];
expY = [30 ; 40 ; 50];
expZ = [40 ; 50 ; 60];

[x, y, z] = midPoint3d(p1, p2);
testCase.assertEqual(expX, x);
testCase.assertEqual(expY, y);
testCase.assertEqual(expZ, z);



function test_edge(testCase)

edge = [10 20 30 30 40 50];
exp = [20 30 40];
mid = midPoint3d(edge);
testCase.assertEqual(exp, mid);


function test_edgeArray(testCase)

edge = [10 20 30 30 40 50; 30 40 50 50 60 70; 50 60 70 70 80 90];
exp = [20 30 40;40 50 60; 60 70 80];
mid = midPoint3d(edge);
testCase.assertEqual(exp, mid);

