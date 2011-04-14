function test_suite = testExpandPolygon(varargin) %#ok<STOUT>
%TESTEXPANDPOLYGON  One-line description here, please.
%   output = testExpandPolygon(input)
%
%   Example
%   testExpandPolygon
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-17,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;

function testSquare %#ok<*DEFNU>
p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
square = [p1;p2;p3;p4];

expanded5 = [5 5;25 5;25 25;5 25];
expanded = expandPolygon(square, 5);
assertTrue(length(expanded)==1);
assertTrue(distancePolygons(expanded{1}, expanded5)<1e-14);

function testOverlap

% a polygon whose expansion overlaps at critical distance 10
poly = [10 10;190 10;190 140;110 140;110 120;150 120;150 50;50 50;50 100;90 100;90 160;10 160];

% small value: only one outline
expanded = expandPolygon(poly, 5);
assertTrue(length(expanded)==1);

% value>10: two outlines
expanded = expandPolygon(poly, 20);
assertTrue(length(expanded)==2);

% value>30: the inner outline disappear
expanded = expandPolygon(poly, 35);
assertTrue(length(expanded)==1);

