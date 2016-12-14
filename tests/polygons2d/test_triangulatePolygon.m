function test_suite = test_triangulatePolygon
%TEST_TRIANGULATEPOLYGON  Test case for the file triangulatePolygon
%
%   Test case for the file triangulatePolygon

%   Example
%   test_triangulatePolygon
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions); 

function test_Simple(testCase) %#ok<*DEFNU>
% Test for a simple polygon
poly = [0 0 ; 10 0;5 10;15 15;5 20;-5 10];
tri = triangulatePolygon(poly);

testCase.assertEqual([4 3], size(tri));

function test_Constrained(testCase)
% Polygon whose two vertices are close but not in the same triangle
poly = [10 10;80 10; 140 20;30 20; 80 30; 140 30; 120 40;10 40];
tri = triangulatePolygon(poly);

testCase.assertEqual([6 3], size(tri));

% the two problematic polygons are indices 2 and 5, 
% so we check they do not belong to a common triangle
testCase.assertEqual(0, sum(sum(ismember(tri, [2 5]), 2) == 2));
