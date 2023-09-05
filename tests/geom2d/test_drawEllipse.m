function tests = test_drawEllipse
% Test suite for the file drawEllipse.
%
%   Test suite for the file drawEllipse
%
%   Example
%   test_drawEllipse
%
%   See also
%     drawEllipse

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-05,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

elli = [40 30  40 10  30];

hf = 101;
figure(hf); clf;
hc = drawEllipse(elli);

assertTrue(testCase, ishghandle(hc));

close(hf);


function test_DrawMany(testCase) %#ok<*DEFNU>
% Test call of function without argument.

elli = [40 30  40 10  30; 60 20 40 10 60];

hf = 101;
figure(hf); clf;
hc = drawEllipse(elli);

assertTrue(testCase, all(ishghandle(hc)));
assertEqual(testCase, length(hc), 2);

close(hf);
