function test_suite = test_nndist
%TEST_NNDIST  One-line description here, please.
%
%   output = test_nndist(input)
%
%   Example
%   test_nndist
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2016-07-17,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2016 INRA - Cepia Software Platform.


test_suite = functiontests(localfunctions); 

function testTwoPoints(testCase) %#ok<*DEFNU>
% compute for two points

p1 = [10 10];
p2 = [20 10];
pts = [p1 ; p2];

[dists, inds] = nndist(pts);

testCase.assertEqual([10; 10], dists, 'AbsTol', .01);
testCase.assertEqual([2;1], inds, 'AbsTol', .01);


function testFourPoints(testCase) %#ok<*DEFNU>
% compute for four points

p1 = [10 10];
p2 = [20 10];
p3 = [20 30];
p4 = [50 30];
pts = [p1 ; p2 ; p3 ; p4];

[dists, inds] = nndist(pts);

testCase.assertEqual([10; 10; 20; 30], dists, 'AbsTol', .01);
testCase.assertEqual([2;1;2;3], inds, 'AbsTol', .01);
