function test_suite = testIntersectCircles(varargin) %#ok<STOUT>
%TESTINTERSECTCIRCLES  One-line description here, please.
%   output = testIntersectCircles(input)
%
%   Example
%   testIntersectCircles
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;


function testTwoCircles %#ok<*DEFNU>

r = 10;
c1 = [0 0 r];
c2 = [r 0 r];

h = r*sqrt(3)/2;
exp = [r/2 -h ; r/2 h];

inters = intersectCircles(c1, c2);
assertAlmostEqual(exp, inters);

