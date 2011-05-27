function test_suite = testPolygonLength(varargin) %#ok<STOUT>
%TESTPOLYGONLENGTH  One-line description here, please.
%
%   output = testPolygonLength(input)
%
%   Example
%   testPolygonLength
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-27,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function testSquare %#ok<*DEFNU>
% Tests with a square of perimeter 40
p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
square = [p1;p2;p3;p4];
exp = 40;

assertEqual(exp, polygonLength(square));

function testSquareSplitArgs
% Tests with a square of perimeter 40
p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
square = [p1;p2;p3;p4];
exp = 40;

assertEqual(exp, polygonLength(square(:,1), square(:,2)));
