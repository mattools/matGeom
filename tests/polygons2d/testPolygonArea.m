function test_suite = testPolygonArea(varargin) %#ok<STOUT>
%TESTPOLYGONAREA  Test case for the file polygonArea
%
%   Test case for the file polygonArea

%   Example
%   testPolygonArea
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-09-26,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function test_SimpleSquare %#ok<*DEFNU>
% Test for a square in CCW (direct) orientation

poly = [0 0;10 0;10 10;0 10];

res = polygonArea(poly);
exp = 100;

assertEqual(exp, res);

function test_ClosedSquare

poly = [0 0;10 0;10 10;0 10; 0 0];

res = polygonArea(poly);
exp = 100;

assertEqual(exp, res);


function test_RevertedSquare %#ok<*DEFNU>
% Test for a square in CW orientation

poly = [0 0;0 10;10 10;10 0];

res = polygonArea(poly);
exp = -100;

assertEqual(exp, res);
