function test_suite = testMinimumCaliperDiameter(varargin)
%TESTMINIMUMCALIPERDIAMETER  One-line description here, please.
%
%   output = testMinimumCaliperDiameter(input)
%
%   Example
%   testMinimumCaliperDiameter
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-04-14,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


initTestSuite;

function testSquare %#ok<*DEFNU>

p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
square = [p1;p2;p3;p4];

width = minimumCaliperDiameter(square);
assertEqual(10, width);

function testRectangle

p1 = [10 10];
p2 = [20 10];
p3 = [20 50];
p4 = [10 50];
square = [p1;p2;p3;p4];

width = minimumCaliperDiameter(square);
assertEqual(10, width);

function testCross

pts = [...
    10 40; ...
    50 40; ...
    50 20; ...
    70 20; ...
    70 40; ...
    110 40; ...
    110 60; ...
    70 60; ...
    70 80; ...
    50 80; ...
    50 60; ...
    10 60];
width = minimumCaliperDiameter(pts);
assertEqual(60, width);

% try again by shuffling vertices
pts = pts([ 4 10 6 12 2 11 8 1 5 3 9 7], :);
width = minimumCaliperDiameter(pts);
assertEqual(60, width);
