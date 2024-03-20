function tests = test_drawAxis3d
% Test suite for the file drawAxis3d.
%
%   Test suite for the file drawAxis3d
%
%   Example
%   test_drawAxis3d
%
%   See also
%     drawAxis3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-06,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);


function test_Empty(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hf = 101;
figure(hf); clf;

ha = drawAxis3d;

assertTrue(testCase, all(ishghandle(ha)));

close(hf);


