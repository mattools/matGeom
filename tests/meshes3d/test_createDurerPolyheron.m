function test_suite = test_createDurerPolyheron(varargin) %#ok<STOUT>
%TEST_CREATEDURERPOLYHERON  Test case for the file createDurerPolyheron
%
%   Test case for the file createDurerPolyheron

%   Example
%   test_createDurerPolyheron
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-07-31,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

initTestSuite;

function test_Simple %#ok<*DEFNU>
% Test call of function without argument
[v f] = createDurerPolyhedron;
assertEqual([12 3], size(v));
assertEqual(8, length(f));

function test_VEF
% Test call of function without argument
[v e f] = createDurerPolyhedron;
assertEqual([12 3], size(v));
assertEqual([18 2], size(e));
assertEqual(8, length(f));
