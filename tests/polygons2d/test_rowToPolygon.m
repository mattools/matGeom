function test_suite = test_rowToPolygon
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

test_suite = functiontests(localfunctions); 

function test_square(testCase) %#ok<*DEFNU>

square = [10 10 ; 20 10 ; 20 20 ; 10 20];

row = polygonToRow(square);
square2 = rowToPolygon(row);
testCase.assertEqual(square, square2);

row = polygonToRow(square, 'interlaced');
square2 = rowToPolygon(row, 'interlaced');
testCase.assertEqual(square, square2);

row = polygonToRow(square, 'packed');
square2 = rowToPolygon(row, 'packed');
testCase.assertEqual(square, square2);

