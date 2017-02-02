function test_suite = test_circle3dPosition
%TEST_CIRCLE3DPOSITION  One-line description here, please.
%
%   output = test_circle3dPosition(input)
%
%   Example
%   testCirclePosition
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function testBasicPoints(testCase) %#ok<*DEFNU>

% create basic 3D circle
circle = [10 20 30  50  60 30 20];

pos60 = circle3dPosition(circle3dPoint(circle, 60), circle);
testCase.assertEqual(60, pos60, 'AbsTol', .001);

pos20 = circle3dPosition(circle3dPoint(circle, 20), circle);
testCase.assertEqual(20, pos20, 'AbsTol', .001);

pos230 = circle3dPosition(circle3dPoint(circle, 230), circle);
testCase.assertEqual(230, pos230, 'AbsTol', .001);

