function test_suite = testGrNodeDegree(varargin) %#ok<STOUT>
%TESTGRNODEDEGREE  test suite for function grNodeDegree
%
%   output = testGrNodeDegree(input)
%
%   Example
%   testGrNodeDegree
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-18,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


initTestSuite;

function testSimpleNode %#ok<*DEFNU>

[nodes edges] = createTestGraph01(); %#ok<ASGLU>

deg1 = grNodeDegree(1, edges);
assertEqual(3, deg1);


function testAllNodes

[nodes edges] = createTestGraph01(); %#ok<ASGLU>

deg = grNodeDegree(1:8, edges);
exp = [3 3 2 2 4 2 3 1];
assertEqual(exp, deg);

