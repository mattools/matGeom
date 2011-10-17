function test_suite = test_isParallel(varargin) %#ok<STOUT>
%TESTISPARALLEL  One-line description here, please.
%   output = testIsParallel(input)
%
%   Example
%   testIsParallel
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;


function testParallel %#ok<*DEFNU>

v1 = [1 2];
v2 = [2 4];
b  = isParallel(v1, v2);
assertTrue(b);


function testNotParallel

v1 = [1 2];
v2 = [2 5];
b  = isParallel(v1, v2);
assertFalse(b);


function testArraySingle

v1  = [1 0;1 1;1 2];
v2  = [2 4];
th  = [false; false; true];
res = isParallel(v1, v2);
assertEqual(res, th);


function testSingleArray

v1  = [2 4];
v2  = [1 0;1 1;1 2];
th  = [false; false; true];
res = isParallel(v1, v2);
assertEqual(res, th);
