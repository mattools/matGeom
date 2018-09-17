function test_suite = test_createSoccerBall
%TESTCREATESoccerBall  One-line description here, please.
%
%   output = testCreateSoccerBall(input)
%
%   Example
%   testCreateSoccerBall
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function testCreation(testCase) %#ok<*DEFNU>

createSoccerBall();


function testVEFCreation(testCase)

[v, e, f] = createSoccerBall();
testCase.assertTrue(~isempty(v));
testCase.assertTrue(~isempty(e));
testCase.assertTrue(~isempty(f));

[nv, ne, nf] = getMeshElementsNumber;
testCase.assertEqual([nv 3], size(v));
testCase.assertEqual([ne 2], size(e));
testCase.assertEqual(nf, length(f));


function testVFCreation(testCase)

[v, f] = createSoccerBall();
testCase.assertTrue(~isempty(v));
testCase.assertTrue(~isempty(f));

[nv, ne, nf] = getMeshElementsNumber; %#ok<ASGLU>
testCase.assertEqual([nv 3], size(v));
testCase.assertEqual(nf, length(f));


function testMeshCreation(testCase)

mesh = createSoccerBall();
testCase.assertTrue(isstruct(mesh));
testCase.assertTrue(isfield(mesh, 'vertices'));
testCase.assertTrue(isfield(mesh, 'edges'));
testCase.assertTrue(isfield(mesh, 'faces'));

[nv, ne, nf] = getMeshElementsNumber;
testCase.assertEqual([nv 3], size(mesh.vertices));
testCase.assertEqual([ne 2], size(mesh.edges));
testCase.assertEqual(nf, length(mesh.faces));


function [nv, ne, nf] = getMeshElementsNumber

nv = 60;
ne = 90;
nf = 32;
