function test_suite = test_polygonCentroid(varargin) %#ok<STOUT>
%TEST_POLYGONCENTROID  Test case for the file polygonCentroid
%
%   Test case for the file polygonCentroid

%   Example
%   test_polygonCentroid
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

initTestSuite;

function test_Square %#ok<*DEFNU>
% Test call of function without argument
square = [0 0;10 0;10 10;0 10];

centro = polygonCentroid(square);
assertEqual([5 5], centro);

function test_SquareMultiVertices
% Test call of function without argument
square = [0 0;10 0;10 10;10 10;0 10;0 0];

centro = polygonCentroid(square);
assertEqual([5 5], centro);

function test_Lozenge
% Test call of function without argument
poly = [10 10;20 20;10 30;0 20];

centro = polygonCentroid(poly);
assertEqual([10 20], centro);

