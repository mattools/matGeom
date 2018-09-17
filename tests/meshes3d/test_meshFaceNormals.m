function test_suite = test_meshFaceNormals
%TEST_FACENORMAL  Test case for the file meshFaceNormals
%
%   Test case for the file meshFaceNormals

%   Example
%   test_meshFaceNormals
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-01-30,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Cube(testCase) %#ok<*DEFNU>
% Test call of function without argument
[v, f] = createCube;
n = meshFaceNormals(v, f);
exp = [0 0 -1; 0 0 1; 1 0 0; -1 0 0; 0 -1 0; 0 1 0];
testCase.assertEqual(exp, n, 'AbsTol', 1e-10);



