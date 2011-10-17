function test_suite = test_grFindGeodesicPath(varargin) %#ok<STOUT>
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


initTestSuite;

function testGraph01 %#ok<*DEFNU>

[nodes edges] = createTestGraph01;
path = grFindGeodesicPath(nodes, edges, 3, 8);
exp = [4 1 3 10];
assertEqual(exp, path);

function testGraph03

[nodes edges] = createTestGraph03;
path = grFindGeodesicPath(nodes, edges, 1, 12);
exp = [1 2 5 7 11 13];
assertEqual(exp, path);
