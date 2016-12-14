function test_suite = test_graphPeripheralVertices
%TEST_GRAPHPERIPHERALVERTICES  One-line description here, please.
%
%   output = test_graphPeripheralVertices(input)
%
%   Example
%   test_graphPeripheralVertices
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-19,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


test_suite = functiontests(localfunctions); 

function testGraph02(testCase) %#ok<*DEFNU>

[nodes, edges] = createTestGraph02;
verts = graphPeripheralVertices(nodes, edges);

exp = [1;2;11;12];
testCase.assertEqual(exp, verts);

