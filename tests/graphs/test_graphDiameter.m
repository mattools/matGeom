function test_suite = test_graphDiameter(varargin) %#ok<STOUT>
%TEST_GRAPHDIAMETER  One-line description here, please.
%
%   output = test_graphDiameter(input)
%
%   Example
%   testGraphDiameter
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
diam = graphDiameter(nodes, edges);

exp = 6;
assertEqual(exp, diam);

