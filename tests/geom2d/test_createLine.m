function test_suite = test_createLine(varargin) %#ok<STOUT>
%testCreateLine  One-line description here, please.
%   output = testCreateLine(input)
%
%   Example
%   testCreateLine
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

function testCreateLine2Points %#ok<*DEFNU>

p1 = [1 1];
p2 = [2 3];
line = createLine(p1, p2);

assertElementsAlmostEqual(p1, line(1,1:2));
assertElementsAlmostEqual(p2-p1, line(1,3:4));

function testCreateLine2Arrays

p1 = [1 1;1 1];
p2 = [2 3;2 4];
line = createLine(p1, p2);

assertEqual(2, size(line, 1));
assertElementsAlmostEqual(p1, line(:,1:2));
assertElementsAlmostEqual(p2-p1, line(:,3:4));

