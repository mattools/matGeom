function test_suite = testIsPerpendicular3d(varargin) %#ok<STOUT>
%Check orthogonality 2 vectors
%   output = testIsPerpendicular3d(input)
%
%   Example
%   testIsPerpendicular3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

initTestSuite;

function testSingle %#ok<*DEFNU>
v1  = [10 0 0];
v2  = [0 20 0];
v3  = [0 0 30];

assertTrue(isPerpendicular3d(v1, v2));
assertTrue(isPerpendicular3d(v1, v3));
assertTrue(isPerpendicular3d(v2, v3));

function testNegative
v1  = [10 0 0];
v2  = [-1 -5 0];

assertFalse(isPerpendicular3d(v1, v2));

function testSingleArray
v1  = [10 0 0];
v2  = [0 20 0];
v3  = [0 0 30];
res = isPerpendicular3d(v1, [v1; v2; v3]);
assertEqual([false;true;true], res);

function testArraySingle
v1  = [10 0 0];
v2  = [0 20 0];
v3  = [0 0 30];
res = isPerpendicular3d([v1; v2; v3], v1);
assertEqual([false;true;true], res);

