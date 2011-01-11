function test_suite = testMidPoint(varargin) %#ok<STOUT>
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

p1 = [10 20 30];
p2 = [30 40 50];
exp = [20 30 40];
mid = midPoint3d(p1, p2);
assertEqual(exp, mid);


function test_twoPointArrays

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
assertEqual(exp, mid);

function test_pointArray

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
assertEqual(exp, mid);

function test_arrayPoint

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
assertEqual(exp, mid);


function test_returnThreeOutputs

p1 = [ ...
    10 20 30; ...
    30 40 50; ...
    50 60 70; ...
    ];
p2 = [30 40 50];

expX = [20 ; 30 ; 40];
expY = [30 ; 40 ; 50];
expZ = [40 ; 50 ; 60];

[x y z] = midPoint3d(p1, p2);
assertEqual(expX, x);
assertEqual(expY, y);
assertEqual(expZ, z);



function test_edge

edge = [10 20 30 30 40 50];
exp = [20 30 40];
mid = midPoint3d(edge);
assertEqual(exp, mid);


function test_edgeArray

edge = [10 20 30 30 40 50; 30 40 50 50 60 70; 50 60 70 70 80 90];
exp = [20 30 40;40 50 60; 60 70 80];
mid = midPoint3d(edge);
assertEqual(exp, mid);

