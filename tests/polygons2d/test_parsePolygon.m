function test_suite = test_parsePolygon
%TEST_PARSEPOLYGON Tests for parsePolygon.
%
%   Example
%     runtests('test_parsePolygon')
%

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-01-04, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023

test_suite = functiontests(localfunctions);

function test_nan2cell(testCase) 
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
nanPoly = [oRectangle; nan nan; iRectangle];
cellPoly_exp = {oRectangle, iRectangle};
cellPoly = parsePolygon(nanPoly, 'cell');

testCase.assertEqual(cellPoly, cellPoly_exp);

function test_nan2repetition(testCase) 
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
nanPoly = [oRectangle; nan nan; iRectangle];
repPoly_exp = [oRectangle; oRectangle(1,:); iRectangle; iRectangle(1,:)];
cellPoly = parsePolygon(nanPoly, 'repetition');

testCase.assertEqual(cellPoly, repPoly_exp);

function test_nan2polyshape(testCase) 
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
nanPoly = [oRectangle; nan nan; iRectangle];
polyshapePoly_exp = polyshape(oRectangle);
polyshapePoly_exp = addboundary(polyshapePoly_exp, iRectangle);
polyshapePoly = parsePolygon(nanPoly, 'polyshape');

testCase.assertEqual(polyshapePoly, polyshapePoly_exp);


function test_repetition2cell(testCase)
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
repPoly = [oRectangle; oRectangle(1,:); iRectangle; iRectangle(1,:)];
cellPoly_exp = {oRectangle, iRectangle};
cellPoly = parsePolygon(repPoly, 'cell');

testCase.assertEqual(cellPoly, cellPoly_exp);

function test_repetition2nan(testCase)
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
repPoly = [oRectangle; oRectangle(1,:); iRectangle; iRectangle(1,:)];
nanPoly_exp = [oRectangle; nan nan; iRectangle];
nanPoly = parsePolygon(repPoly, 'nan');

testCase.assertEqual(nanPoly, nanPoly_exp);

function test_repetition2polyshape(testCase)
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
repPoly = [oRectangle; oRectangle(1,:); iRectangle; iRectangle(1,:)];
polyshapePoly_exp = polyshape(oRectangle);
polyshapePoly_exp = addboundary(polyshapePoly_exp, iRectangle);
polyshapePoly = parsePolygon(repPoly, 'polyshape');

testCase.assertEqual(polyshapePoly, polyshapePoly_exp);


function test_cell2nan(testCase) 
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
cellPoly = {oRectangle, iRectangle};
nanPoly_exp = [oRectangle; nan nan; iRectangle];
nanPoly = parsePolygon(cellPoly, 'nan');

testCase.assertEqual(nanPoly, nanPoly_exp);

function test_cell2repetition(testCase) 
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
cellPoly = {oRectangle, iRectangle};
repPoly_exp = [oRectangle; oRectangle(1,:); iRectangle; iRectangle(1,:)];
repPoly = parsePolygon(cellPoly, 'repetition');

testCase.assertEqual(repPoly, repPoly_exp);

function test_cell2polyshape(testCase) 
oRectangle = [0 0;10 0;10 10;0 10];
iRectangle = flipud(0.5*[0 0;10 0;10 10;0 10]+1);
cellPoly = {oRectangle, iRectangle};
polyshapePoly_exp = polyshape(oRectangle);
polyshapePoly_exp = addboundary(polyshapePoly_exp, iRectangle);
polyshapePoly = parsePolygon(cellPoly, 'polyshape');

testCase.assertEqual(polyshapePoly, polyshapePoly_exp);
