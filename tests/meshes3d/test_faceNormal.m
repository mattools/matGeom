function test_suite = test_faceNormal(varargin) %#ok<STOUT>
%TEST_FACENORMAL  Test case for the file faceNormal
%
%   Test case for the file faceNormal

%   Example
%   test_faceNormal
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2014-01-30,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2014 INRA - Cepia Software Platform.

initTestSuite;

function test_Cube %#ok<*DEFNU>
% Test call of function without argument
[v f] = createCube;
n = faceNormal(v, f);
exp = [0 0 -1; 0 0 1; 1 0 0; -1 0 0; 0 -1 0; 0 1 0];
assertElementsAlmostEqual(exp, n, 'absolute', 1e-10);



