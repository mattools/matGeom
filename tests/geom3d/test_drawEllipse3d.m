function tests = test_drawEllipse3d
% Test suite for the file drawEllipse3d.
%
%   Test suite for the file drawEllipse3d
%
%   Example
%   test_drawEllipse3d
%
%   See also
%     drawEllipse3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-06,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

ellXY = [0 0 0  8 5  0 0 0];

hf = 101;
figure(hf); clf;
hc = drawEllipse3d(ellXY);

assertTrue(testCase, ishghandle(hc));

close(hf);

