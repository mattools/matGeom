function test_suite = testGrFindMaximalLengthPath(varargin) %#ok<STOUT>
%TESTGRFINDMAXIMALLENGTHPATH  One-line description here, please.
%
%   output = testGrFindMaximalLengthPath(input)
%
%   Example
%   testGrFindMaximalLengthPath
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-05-22,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


initTestSuite;

function testGraph03 %#ok<*DEFNU>

[nodes edges] = createTestGraph03;
path = grFindMaximalLengthPath(nodes, edges);
exp = [1 2 5 7 11 13];
assertEqual(exp, path);
