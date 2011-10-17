function test_suite = test_intersectBoxes(varargin) %#ok<STOUT>
%testIntersectBoxes  One-line description here, please.
%
%   output = testIntersectBoxes(input)
%
%   Example
%   testIntersectBoxes
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


initTestSuite;

function testBasic %#ok<*DEFNU>
box1 = [5 20 10 25];
box2 = [0 15 15 20];
exp  = [5 15 15 20];
box = intersectBoxes(box1, box2);
assertElementsAlmostEqual(exp, box);
