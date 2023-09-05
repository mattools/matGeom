function tests = test_drawCircleArc
% Test suite for the file drawCircleArc.
%
%   Test suite for the file drawCircleArc
%
%   Example
%   test_drawCircleArc
%
%   See also
%     drawCircleArc

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-05,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

ca = [40 30 10  -30 60];

hf = 101;
figure(hf); clf;
hc = drawCircleArc(ca);

assertTrue(testCase, ishghandle(hc));

close(hf);


function test_DrawMany(testCase) %#ok<*DEFNU>
% Test call of function without argument.

ca = [40 30 10  -30 60; 40 30 10  150 60];

hf = 101;
figure(hf); clf;
hc = drawCircleArc(ca);

assertTrue(testCase, all(ishghandle(hc)));
assertEqual(testCase, length(hc), 2);

close(hf);
