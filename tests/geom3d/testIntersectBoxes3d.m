function test_suite = testIntersectBoxes3d(varargin)
%TESTINTERSECTBOXES3D  One-line description here, please.
%
%   output = testIntersectBoxes3d(input)
%
%   Example
%   testIntersectBoxes3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


initTestSuite;

function testBasic
box1 = [5 20 5 30 10 50];
box2 = [0 15 0 15 0 20];
box = intersectBoxes3d(box1, box2);
assertElementsAlmostEqual([5 15 5 15 10 20], box);

