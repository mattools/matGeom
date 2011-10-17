function test_suite = test_midPoint(varargin) %#ok<STOUT>
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

initTestSuite;

function test_twoPoints %#ok<*DEFNU>

p1 = [10 20];
p2 = [30 40];
exp = [20 30];
mid = midPoint(p1, p2);
assertEqual(exp, mid);


function test_twoPointArrays

p1 = [ ...
    10 20 ; ...
    30 40 ; ...
    50 60 ; ...
    ];
p2 = [ ...
    30 40; ...
    50 60; ...
    70 80];
exp = [...
    20 30; ...
    40 50; ...
    60 70];

mid = midPoint(p1, p2);
assertEqual(exp, mid);

function test_pointArray

p1 = [30 40];
p2 = [ ...
    30 40; ...
    50 60; ...
    70 80];
exp = [...
    30 40; ...
    40 50; ...
    50 60];

mid = midPoint(p1, p2);
assertEqual(exp, mid);

function test_arrayPoint

p1 = [ ...
    10 20 ; ...
    30 40 ; ...
    50 60 ; ...
    ];
p2 = [30 40];
exp = [...
    20 30; ...
    30 40; ...
    40 50];

mid = midPoint(p1, p2);
assertEqual(exp, mid);


function test_returnTwoOutputs

p1 = [ ...
    10 20 ; ...
    30 40 ; ...
    50 60 ; ...
    ];
p2 = [30 40];

expX = [20 ; 30 ; 40];
expY = [30 ; 40 ; 50];

[x y] = midPoint(p1, p2);
assertEqual(expX, x);
assertEqual(expY, y);



function test_edge

edge = [10 20 30 40];
exp = [20 30];
mid = midPoint(edge);
assertEqual(exp, mid);


function test_edgeArray

edge = [10 20 30 40; 30 40 50 60; 50 60 70 80];
exp = [20 30;40 50; 60 70];
mid = midPoint(edge);
assertEqual(exp, mid);

