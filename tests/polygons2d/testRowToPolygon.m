function test_suite = testRowToPolygon(varargin) %#ok<STOUT>
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

function test_square %#ok<*DEFNU>

square = [10 10 ; 20 10 ; 20 20 ; 10 20];

row = polygonToRow(square);
square2 = rowToPolygon(row);
assertEqual(square, square2);

row = polygonToRow(square, 'interlaced');
square2 = rowToPolygon(row, 'interlaced');
assertEqual(square, square2);

row = polygonToRow(square, 'packed');
square2 = rowToPolygon(row, 'packed');
assertEqual(square, square2);

