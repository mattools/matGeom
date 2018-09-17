function test_suite = test_grFindGeodesicPath
%TEST_GRFINDGEODESICPATH  One-line description here, please.
%
%   output = test_grFindGeodesicPath(input)
%
%   Example
%   testGrFindGeodesicPath
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


test_suite = functiontests(localfunctions); 

function testGraph01(testCase) %#ok<*DEFNU>

[nodes, edges] = createTestGraph01;
path = grFindGeodesicPath(nodes, edges, 3, 8);
exp = [4 1 3 10];
testCase.assertEqual(exp, path);

function testGraph03(testCase)

[nodes, edges] = createTestGraph03;
path = grFindGeodesicPath(nodes, edges, 1, 12);
exp = [1 2 5 7 11 13];
testCase.assertEqual(exp, path);
