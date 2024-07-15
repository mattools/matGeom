function tests = test_meshEquivalentEllipsoid
% Test suite for the file meshEquivalentEllipsoid.
%
%   Test suite for the file meshEquivalentEllipsoid
%
%   Example
%   test_meshEquivalentEllipsoid
%
%   See also
%     meshEquivalentEllipsoid

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2024-07-15,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE - BIA-BIBS.

tests = functiontests(localfunctions);

function test_Simple(testCase) %#ok<*DEFNU>
% Test call of function without argument.

mesh = readMesh('bunny_F1k.ply');

elli = meshEquivalentEllipsoid(mesh);

assertEqual(testCase, size(elli), [1 9]);


