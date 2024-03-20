function tests = test_drawArrow3d
% Test suite for the file drawArrow3d.
%
%   Test suite for the file drawArrow3d
%
%   Example
%   test_drawArrow3d
%
%   See also
%     drawArrow3d

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2023-09-10,    using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

pos = [50 40 30];
vec = [5 4 3];

hFig = figure;
h = drawArrow3d(pos, vec);

assertTrue(testCase, isscalar(h));
assertTrue(testCase, ishghandle(h));

close(hFig);


function test_drawMany(testCase) %#ok<*DEFNU>

[x, y] = meshgrid(1:5, 1:4);
z = zeros(size(x));
pos = [x(:) y(:) z(:)];
vec = zeros(size(pos));
vec(:,1) = 1;

hFig = figure;
h = drawArrow3d(pos, vec, 'g', 'stemRatio', 0.6);

assertEqual(testCase, length(h), size(pos,1));
assertTrue(testCase, all(ishghandle(h)));

close(hFig);

