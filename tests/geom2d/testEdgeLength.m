function test_suite = testEdgeLength(varargin)
% One-line description here, please.
%   output = testEdgeLength(input)
%
%   Example
%   testEdgeLength
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

initTestSuite;

function testSimple

p1 = [2 3];
p2 = [5 7];
edge = createEdge(p1, p2);
len = edgeLength(edge);
assertAlmostEqual(5, len);

function testArray

p1 = [2 3;2 3;3 2;5 7];
p2 = [5 7;5 7;7 5;2 3];
edge = createEdge(p1, p2);
len = edgeLength(edge);

assertEqual(4, size(len, 1));
assertAlmostEqual([5;5;5;5], len);

