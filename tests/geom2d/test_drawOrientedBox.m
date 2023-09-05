function tests = test_drawOrientedBox
% Test suite for the file drawOrientedBox.
%
%   Test suite for the file drawOrientedBox
%
%   Example
%   test_drawOrientedBox
%
%   See also
%     drawOrientedBox

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-05,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);


function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

obox = [40 30  30 10  30];

hf = 101;
figure(hf); clf;
hc = drawOrientedBox(obox);

assertTrue(testCase, ishghandle(hc));

close(hf);


function test_DrawMany(testCase) %#ok<*DEFNU>
% Test call of function without argument.

obox = [40 30  30 10  30; 50 40 40 20 120];

hf = 101;
figure(hf); clf;
hc = drawOrientedBox(obox);

assertTrue(testCase, all(ishghandle(hc)));
assertEqual(testCase, length(hc), 2);

close(hf);
