function tests = test_drawEllipseArc
% Test suite for the file drawEllipseArc.
%
%   Test suite for the file drawEllipseArc
%
%   Example
%   test_drawEllipseArc
%
%   See also
%     drawEllipseArc

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-05,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

ea = [40 30  30 10  30  -30 60];

hf = 101;
figure(hf); clf;
hc = drawEllipseArc(ea);

assertTrue(testCase, ishghandle(hc));

close(hf);


function test_DrawMany(testCase) %#ok<*DEFNU>
% Test call of function without argument.

ea = [40 30  30 10  30  -30 60; 40 30  30 10  30  150 60];

hf = 101;
figure(hf); clf;
hc = drawEllipseArc(ea);

assertTrue(testCase, all(ishghandle(hc)));
assertEqual(testCase, length(hc), 2);

close(hf);
