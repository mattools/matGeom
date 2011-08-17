function test_suite = test_angleDiff(varargin) %#ok<STOUT>
%TEST_ANGLEDIFF  Test case for the file angleDiff
%
%   Test case for the file angleDiff

%   Example
%   test_angleDiff
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-07-27,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function test_Simple %#ok<*DEFNU>
% simple tests


dif = angleDiff(0, pi/2);
assertAlmostEqual(pi/2, dif);

dif = angleDiff(pi/2, 0);
assertAlmostEqual(-pi/2, dif);

dif = angleDiff(0, 3*pi/2);
assertAlmostEqual(-pi/2, dif);

dif = angleDiff(3*pi/2, 0);
assertAlmostEqual(pi/2, dif);
