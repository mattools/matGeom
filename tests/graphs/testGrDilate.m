function test_suite = testGrDilate(varargin) %#ok<STOUT>
%TESTGRDILATE  test suite for function grDilate
%
%   output = testGrDilate(input)
%
%   Example
%   testGrDilate
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

valDil = grDilate(edges, values);
exp = [80;80;70;70;80;50;80;40];
assertEqual(exp, valDil);

