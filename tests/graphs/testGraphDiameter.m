function test_suite = testGraphDiameter(varargin) %#ok<STOUT>
%TESTGRAPHDIAMETER  One-line description here, please.
%
%   output = testGraphDiameter(input)
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

