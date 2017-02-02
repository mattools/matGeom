function test_suite = test_mergeBoxes
%testMergeBoxes  One-line description here, please.
%
%   output = testMergeBoxes(input)
%
%   Example
%   testMergeBoxes
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.


test_suite = functiontests(localfunctions); 

function testBasic(testCase) %#ok<*DEFNU>
box1 = [5 20 10 25];
box2 = [0 15 15 20];
exp  = [0 20 10 25];
box = mergeBoxes(box1, box2);
testCase.assertEqual(exp, box, 'AbsTol', .01);
