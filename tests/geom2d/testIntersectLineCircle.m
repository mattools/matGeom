function  test_suite = testIntersectLineCircle(varargin) %#ok<STOUT>
%TESTINTERSECTLINECIRCLE  One-line description here, please.
%
%   output = testIntersectLineCircle(input)
%
%   Example
%   testIntersectLineCircle
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;


function testIntersect %#ok<*DEFNU>

center = [10 0];
l1 = [center 0 1];
c1 = [center 5];
pts = intersectLineCircle(l1, c1);
exp = [10 -5; 10 5];
assertEqual(exp, pts);

function testTangent

center = [10 0];
l1 = [15 0 0 1];
c1 = [center 5];
pts = intersectLineCircle(l1, c1);
exp = [15 0];
assertEqual(exp, pts);

function testNoIntersect

center = [10 0];
l1 = [16 0 0 1];
c1 = [center 5];
pts = intersectLineCircle(l1, c1);
exp = [NaN NaN;NaN NaN];
assertEqual(exp, pts);

