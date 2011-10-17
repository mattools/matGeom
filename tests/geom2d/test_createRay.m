function test_suite = test_createRay(varargin) %#ok<STOUT>
%testCreateRay  One-line description here, please.
%   output = testCreateRay(input)
%
%   Example
%   testCreateRay
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

function testCreateRay2Points %#ok<*DEFNU>

p1 = [1 1];
p2 = [2 3];
ray = createRay(p1, p2);

assertElementsAlmostEqual(p1, ray(1,1:2));
assertElementsAlmostEqual(p2-p1, ray(1,3:4));

function testCreateRay2Arrays

p1 = [1 1;1 1];
p2 = [2 3;2 4];
ray = createRay(p1, p2);

assertEqual(2, size(ray, 1));
assertElementsAlmostEqual(p1, ray(:,1:2));
assertElementsAlmostEqual(p2-p1, ray(:,3:4));

