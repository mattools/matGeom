function test_suite = test_grPropagateDistance
%TEST_GRPROPAGATEDISTANCE  Test case for the file grPropagateDistance
%
%   Test case for the file grPropagateDistance

%   Example
%   test_grPropagateDistance
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-01-13,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Simple(testCase) %#ok<*DEFNU>
% propagate distance on a graph where a branch has smaller nodes but larger
% cumulated distance

% create graph structure
n0 = [10 10;20 10; 30 10;40 10;50 10;30 40];
e0 = [1 2;1 6; 2 3;3 4;4 5;5 6];
% weights of edges
l0 = [2 5 2 2 2 5]';
% distance of node number 5 should be 8 (four times 2)
dists = grPropagateDistance(n0, e0, 1, l0);
testCase.assertEqual(8, dists(5));


