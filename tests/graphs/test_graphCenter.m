function test_suite = test_graphCenter(varargin) %#ok<STOUT>
%TEST_GRAPHCENTER  One-line description here, please.
%
%   output = test_graphCenter(input)
%
%   Example
%   test_graphCenter
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

