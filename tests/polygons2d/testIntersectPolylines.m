function test_suite = testIntersectPolylines(varargin) %#ok<STOUT>
%TESTROWTOPOLYGON  One-line description here, please.
%
%   output = testRowToPolygon(input)
%
%   Example
%   testRowToPolygon
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-10-29,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

initTestSuite;

function test_simple_polylines %#ok<*DEFNU>
% Compute intersection points between 2 simple polylines
poly1 = [20 10 ; 20 50 ; 60 50 ; 60 10];
poly2 = [10 40 ; 30 40 ; 30 60 ; 50 60 ; 50 40 ; 70 40];
points = intersectPolylines(poly1, poly2);
assertEqual(4, size(points, 1));

exp = [20 40 ; 30 50 ; 50 50 ; 60 40];
assertEqual(exp, points);
