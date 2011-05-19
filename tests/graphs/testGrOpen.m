function test_suite = testGrOpen(varargin) %#ok<STOUT>
%TESTGROPEN  test suite for function grOpen
%
%   output = testGrOpen(input)
%
%   Example
%   testGrOpen
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

function testSimpleGraph %#ok<*DEFNU>

[nodes edges values] = createTestGraph01(); %#ok<ASGLU>

valClo = grOpen(edges, values);
exp = [20;10;50;50;50;20;30;30];
assertEqual(exp, valClo);

