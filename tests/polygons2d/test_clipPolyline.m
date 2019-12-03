function test_suite = test_clipPolyline
% Tests the function 'clipPolyline'
%   output = testClipLine(input)
%
%   Example
%   testClipLine
%
%   See also
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-04-22,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.
% Licensed under the terms of the LGPL, see the file "license.txt"

test_suite = functiontests(localfunctions);

function testSimplePolyline(testCase) %#ok<*DEFNU>
% test clipping of horizontal lines

poly = [-5 0; 5 10;15 0];
box = [0 10 0 15];

exp = [0 5;5 10;10 5];
res = clipPolyline(poly, box);


testCase.assertEqual(length(res), 1);
testCase.assertEqual(res{1}, exp, 'AbsTol', .01);


function testClipCircleIn4(testCase)
% test clipping of horizontal lines

circle = [5 5 6];
poly = circleToPolygon(circle, 200);
box = [0 10 0 10];

res = clipPolyline(poly, box);
testCase.assertEqual(length(res), 4);



% function testVert(testCase)
% % test clipping of vertical lines
% 
% box = [0 100 0 100];
% 
% % inside, upward
% line = [30 40 0 10];
% edge = [30 0 30 100];
% testCase.assertEqual(edge, clipLine(line, box), 'AbsTol', .01);
% 
% % inside, downward
% line = [30 40 0 -10];
% edge = [30 100 30 0];
% testCase.assertEqual(edge, clipLine(line, box), 'AbsTol', .01);
% 
% % outside
% line = [140 30 0 10];
% testCase.assertTrue(sum(isnan(clipLine(line, box)))==4);
% 
% function testDiagUp(testCase)
% % test clipping of upward diagonal lines
% 
% box = [0 100 0 100];
% 
% % inside, top right corner
% line = [80 30 10 10];
% edge = [50 0 100 50];
% testCase.assertEqual(edge, clipLine(line, box), 'AbsTol', .01);
% 
% % inside, down right corner
% line = [20 70 10 10];
% edge = [0 50 50 100];
% testCase.assertEqual(edge, clipLine(line, box), 'AbsTol', .01);
% 
% % outside
% line = [140 -30 10 10];
% testCase.assertTrue(sum(isnan(clipLine(line, box)))==4);
% 
% line = [-40 130 10 10];
% testCase.assertTrue(sum(isnan(clipLine(line, box)))==4);
% 
% 
% function testMultiLines(testCase)
% 
% box = [0 100 0 100];
% 
% % inside, top right corner
% line = [...
%     80 30 10 10; ...
%     20 70 10 10; ...
%     140 -30 10 10; ...
%     -40 130 10 10];
% edge = [...
%     50 0 100 50; ...
%     0 50 50 100; ...
%     NaN NaN NaN NaN; ...
%     NaN NaN NaN NaN; ...
%     ];
% 
% clipped = clipLine(line, box);
% testCase.assertEqual(4, size(clipped, 1));
% testCase.assertEqual(edge(1:2, :), clipped(1:2, :), 'AbsTol', .01);
% testCase.assertTrue(sum(isnan(clipped(3,:)))==4);
% testCase.assertTrue(sum(isnan(clipped(4,:)))==4);
% 
% function testBigBox(testCase)
% % test clipping of horizontal lines
% 
% box = [-1 1 -1 1]*1e10;
% 
% % inside, to the right
% line = [3 0 1 2];
% D = 1e10;
% edge = [3-D/2 -D 3+D/2 D];
% clipped = clipLine(line, box);
% testCase.assertEqual(edge, clipped, 'AbsTol', .01);
% 
% function testBigLine(testCase)
% % test clipping of horizontal lines
% 
% box = [-1 1 -1 1]*100;
% 
% % inside, to the right
% line = [3 0 1*1e10 2*1e10];
% D = 100;
% edge = [3-D/2 -D 3+D/2 D];
% clipped = clipLine(line, box);
% testCase.assertEqual(edge, clipped, 'AbsTol', .01);
