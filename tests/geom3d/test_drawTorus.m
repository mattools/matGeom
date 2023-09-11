function tests = test_drawTorus
% Test suite for the file drawTorus.
%
%   Test suite for the file drawTorus
%
%   Example
%   test_drawTorus
%
%   See also
%     drawTorus

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-10,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hf = figure;
torus = [50 50 50  30 10  30 45];

ht = drawTorus(torus);

assertTrue(testCase, ishghandle(ht));

close(hf);


function test_multiple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

hf = figure;
torus = [50 50 50  30 10  30 45; 50 50 50  30 10  60 45];

ht = drawTorus(torus);

assertEqual(testCase, length(ht), 2);
assertTrue(testCase, all(ishghandle(ht)));

close(hf);



