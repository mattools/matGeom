function test_suite = test_drawRect 
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

test_suite = functiontests(localfunctions);

function testSimple(testCase) %#ok<*DEFNU>

x0 = 20;
y0 = 30;
w = 40;
h = 50;

hf = 101;
figure(hf); clf;
hr = drawRect([x0 y0 w h]);
xth = [x0 x0+w x0+w x0 x0];
yth = [y0 y0 y0+h y0+h y0];
assertEqual(testCase, xth, get(hr, 'XData'), 'AbsTol', .01);
assertEqual(testCase, yth, get(hr, 'YData'), 'AbsTol', .01);

close(hf);


function test_drawMany(testCase) %#ok<*DEFNU>

rects = [20 30 40 50; 50 40 70 70];

hf = 101;
figure(hf); clf;
hr = drawRect(rects);

assertTrue(testCase, all(ishghandle(hr)));
assertEqual(testCase, length(hr), 2);

close(hf);
