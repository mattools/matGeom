function test_suite = testDrawRect(varargin)
%TESTDRAWRECT  One-line description here, please.
%   output = testDrawRect(input)
%
%   Example
%   testDrawRect
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-05-19,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

initTestSuite;

function testSimple

x0 = 20;
y0 = 30;
w = 40;
h = 50;

hf = 101;
figure(hf); clf;
hr = drawRect([x0 y0 w h]);
xth = [x0 x0+w x0+w x0 x0];
yth = [y0 y0 y0+h y0+h y0];
assertElementsAlmostEqual(xth, get(hr, 'XData'));
assertElementsAlmostEqual(yth, get(hr, 'YData'));

close(hf);
