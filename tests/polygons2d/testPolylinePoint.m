function test_suite = testPolylinePoint(varargin)
%TESTPOLYLINEPOINT  One-line description here, please.
%   output = testPolylinePoint(input)
%
%   Example
%   testPolylinePoint
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
assertElementsAlmostEqual(polygonPoint(square, 0), p1);
assertElementsAlmostEqual(polygonPoint(square, 1), p2);
assertElementsAlmostEqual(polygonPoint(square, 2), p3);
assertElementsAlmostEqual(polygonPoint(square, 3), p4);

assertElementsAlmostEqual(polygonPoint(square, 4), p1);
assertElementsAlmostEqual(polygonPoint(square, 3.5), centroid([p1;p4]));
