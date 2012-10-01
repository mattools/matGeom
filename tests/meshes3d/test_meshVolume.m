function test_suite = test_meshVolume(varargin) %#ok<STOUT>
%TEST_MESHVOLUME  Test case for the file meshVolume
%
%   Test case for the file meshVolume

%   Example
%   test_meshVolume
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-01,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

initTestSuite;

function test_Cube %#ok<*DEFNU>
% Test call of function without argument
[v f] = createCube;
vol = meshVolume(v, f);
assertEqual(1, vol);


function test_Tetrahedron
% Test call of function without argument
[v f] = createTetrahedron;
vol = meshVolume(v, f);

% this is not a unit tetrahedron, volume is bigger...
exp = 1 / 3;
assertEqual(exp, vol);

