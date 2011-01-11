function test_suite = testCreateTranslation(varargin)
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
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

initTestSuite;

function testBasic

trans = createTranslation(2, 3);
assertElementsAlmostEqual(trans, [1 0 2;0 1 3;0 0 1]);
