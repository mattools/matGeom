function test_suite = testGrErode(varargin) %#ok<STOUT>
%TESTGRERODE  test suite for function grErode
%
%   output = testGrErode(input)
%
%   Example
%   testGrErode
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

valEro = grErode(edges, values);
exp = [10;10;10;50;10;20;20;30];
assertEqual(exp, valEro);

