function test_suite = test_createTranslation
%TESTCREATETRANSLATION  One-line description here, please.
%   output = testCreateTranslation(input)
%
%   Example
%   testCreateTranslation
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function testBasic(testCase)

trans = createTranslation(2, 3);
testCase.assertEqual(trans, [1 0 2;0 1 3;0 0 1], 'AbsTol', .01);
