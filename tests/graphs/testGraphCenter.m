function test_suite = testGraphCenter(varargin) %#ok<STOUT>
%TESTGRAPHCENTER  One-line description here, please.
%
%   output = testGraphCenter(input)
%
%   Example
%   testGraphCenter
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-19,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


initTestSuite;

function testGraph02 %#ok<*DEFNU>

[nodes edges] = createTestGraph02;
center = graphCenter(nodes, edges);

exp = [6;7];
assertEqual(exp, center);

