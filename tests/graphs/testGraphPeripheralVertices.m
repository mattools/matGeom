function test_suite = testGraphPeripheralVertices(varargin) %#ok<STOUT>
%TESTGRAPHPERIPHERALVERTICES  One-line description here, please.
%
%   output = testGraphPeripheralVertices(input)
%
%   Example
%   testGraphPeripheralVertices
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
verts = graphPeripheralVertices(nodes, edges);

exp = [1;2;11;12];
assertEqual(exp, verts);

