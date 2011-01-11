function test_suite = testDrawEdge3d(varargin)
%Check there is no error when drawing 3D edges
%   output = testDrawEdge3d(input)
%
%   Example
%   testDrawEdge3d
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

initTestSuite;

function testSingle
edge = [1 2 3 4 5 6];
figure(1); clf;
drawEdge3d(edge);
close(1);

function testSingleArray
edges = [1 2 3 4 5 6;3 2 3 6 5 6;1 4 3 4 7 6;1 4 5 4 7 8];
figure(1); clf;
drawEdge3d(edges);
close(1);

function testTwoPointArrays
p1 = [1 2 3;3 2 3;1 4 3;1 4 5];
p2 = [4 5 6;6 5 6;4 7 6;4 7 8];
figure(1); clf;
drawEdge3d(p1, p2);
close(1);
