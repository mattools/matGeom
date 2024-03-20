function tests = test_drawCircle3d
% Test suite for the file drawCircle3d.
%
%   Test suite for the file drawCircle3d
%
%   Example
%   test_drawCircle3d
%
%   See also
%     drawCircle3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-10,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

circ = [10 20 30 50  0  0];

hf = 101;
figure(hf); clf;
hc = drawCircle3d(circ);

assertTrue(testCase, ishghandle(hc));

close(hf);

function test_drawMany(testCase) %#ok<*DEFNU>
% Test call of function without argument.

circ = [10 20 30 50  0  0 ; 10 20 30 50  90  0 ; 10 20 30 50  90  90 ];

hf = 101;
figure(hf); clf;
hc = drawCircle3d(circ);

assertTrue(testCase, all(ishghandle(hc)));
assertEqual(testCase, length(hc), 3);

close(hf);
