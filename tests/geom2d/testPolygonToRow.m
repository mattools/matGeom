function test_suite = testPolygonToRow(varargin) %#ok<STOUT>
%TESTPOLYGONTOROW  One-line description here, please.
%
%   output = testPolygonToRow(input)
%
%   Example
%   testPolygonToRow
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
exp = [10 10   20 10   20 20   10 20];

row = polygonToRow(square);
assertEqual(exp, row);

row = polygonToRow(square, 'interlaced');
assertEqual(exp, row);

exp = [10 20 20 10  10 10 20 20];
row = polygonToRow(square, 'packed');
assertEqual(exp, row);
