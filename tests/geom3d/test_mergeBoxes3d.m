function test_suite = test_mergeBoxes3d
%TESTMERGEBOXES3D  One-line description here, please.
%
%   output = testMergeBoxes3d(input)
%
%   Example
%   testMergeBoxes3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


test_suite = functiontests(localfunctions); 

function testBasic(testCase) %#ok<*DEFNU>
box1 = [5 20 5 30 10 50];
box2 = [0 15 0 15 0 20];
box = mergeBoxes3d(box1, box2);
testCase.assertEqual([0 20 0 30 0 50], box, 'AbsTol', .01);

