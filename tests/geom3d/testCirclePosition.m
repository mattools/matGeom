function test_suite = testCirclePosition(varargin) %#ok<STOUT>
%TESTCIRCLEPOSITION  One-line description here, please.
%
%   output = testCirclePosition(input)
%
%   Example
%   testCirclePosition
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function testBasicPoints %#ok<*DEFNU>

% create basic 3D circle
circle = [10 20 30  50  60 30 20];


pos60 = circle3dPosition(circle3dPoint(circle, 60), circle);
assertElementsAlmostEqual(60, pos60);

pos20 = circle3dPosition(circle3dPoint(circle, 20), circle);
assertElementsAlmostEqual(20, pos20);

pos230 = circle3dPosition(circle3dPoint(circle, 230), circle);
assertElementsAlmostEqual(230, pos230);

