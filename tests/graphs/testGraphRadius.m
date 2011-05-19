function test_suite = testGraphRadius(varargin) %#ok<STOUT>
%testGraphRadius  One-line description here, please.
%
%   output = testGraphRadius(input)
%
%   Example
%   testGraphRadius
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
r = graphRadius(nodes, edges);

exp = 3;
assertEqual(exp, r);

