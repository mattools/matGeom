function tests = test_drawCircle
% Test suite for the file drawCircle.
%
%   Test suite for the file drawCircle
%
%   Example
%   test_drawCircle
%
%   See also
%     drawCircle

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-05,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

circ = [40 30  10];

hf = 101;
figure(hf); clf;
hc = drawCircle(circ);

assertTrue(testCase, ishghandle(hc));

close(hf);


function test_DrawMany(testCase) %#ok<*DEFNU>
% Test call of function without argument.

circ = [40 30  10; 50 40 20];

hf = 101;
figure(hf); clf;
hc = drawCircle(circ);

assertTrue(testCase, all(ishghandle(hc)));
assertEqual(testCase, length(hc), 2);

close(hf);
