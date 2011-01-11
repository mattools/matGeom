function test_suite = testPolygonSubcurve(varargin)
%TESTPOLYGONSUBCURVE  One-line description here, please.
%   output = testPolygonSubcurve(input)
%
%   Example
%   testPolygonSubcurve
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-16,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;

function testSquare

p1 = [10 10];
p2 = [20 10];
p3 = [20 20];
p4 = [10 20];
square = [p1;p2;p3;p4];

subcurve = polygonSubcurve(square, .5, 1.5);
assertElementsAlmostEqual(subcurve, [15 10;20 10;20 15]);

subcurve = polygonSubcurve(square, 3.5, .5);
assertElementsAlmostEqual(subcurve, [10 15;10 10;15 10]);
