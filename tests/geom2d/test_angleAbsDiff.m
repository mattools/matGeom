function test_suite = test_angleAbsDiff(varargin) %#ok<STOUT>
%TEST_ANGLEABSDIFF  Test case for the file angleAbsDiff
%
%   Test case for the file angleDiff

%   Example
%   test_angleAbsDiff
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

exp = pi/2;

dif = angleAbsDiff(pi/2, 0);
assertAlmostEqual(exp, dif);

dif = angleAbsDiff(0, pi/2);
assertAlmostEqual(exp, dif);

dif = angleAbsDiff(0, 3*pi/2);
assertAlmostEqual(exp, dif);

dif = angleAbsDiff(3*pi/2, 0);
assertAlmostEqual(exp, dif);
