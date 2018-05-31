function test_suite = test_createCube
%TESTCREATECUBE  One-line description here, please.
%
%   output = testCreateCube(input)
%
%   Example
%   testCreateCube
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2010-12-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function testCreation(testCase) %#ok<*DEFNU>

createCube();


function testVEFCreation(testCase)

[v, e, f] = createCube();
testCase.assertTrue(~isempty(v));
testCase.assertTrue(~isempty(e));
testCase.assertTrue(~isempty(f));

[nv, ne, nf] = getMeshElementsNumber;
testCase.assertEqual([nv 3], size(v));
testCase.assertEqual([ne 2], size(e));
testCase.assertEqual(nf, length(f));


function testVFCreation(testCase)

[v, f] = createCube();
testCase.assertTrue(~isempty(v));
testCase.assertTrue(~isempty(f));

[nv, ne, nf] = getMeshElementsNumber; %#ok<ASGLU>
testCase.assertEqual([nv 3], size(v));
testCase.assertEqual(nf, length(f));


function testMeshCreation(testCase)

mesh = createCube();
testCase.assertTrue(isstruct(mesh));
testCase.assertTrue(isfield(mesh, 'vertices'));
testCase.assertTrue(isfield(mesh, 'edges'));
testCase.assertTrue(isfield(mesh, 'faces'));

[nv, ne, nf] = getMeshElementsNumber;
testCase.assertEqual([nv 3], size(mesh.vertices));
testCase.assertEqual([ne 2], size(mesh.edges));
testCase.assertEqual(nf, length(mesh.faces));


function testFacesOutwards(testCase)

[v, e, f] = createCube(); %#ok<ASGLU>

centro = centroid(v);
fc  = meshFaceCentroids(v, f);
fc2 = createVector(centro, fc);
n   = meshFaceNormals(v, f);

testCase.assertEqual(size(n), size(fc2));

dp = dot(fc2, n, 2);

testCase.assertTrue(sum(dp <= 0) == 0);


function [nv, ne, nf] = getMeshElementsNumber

nv = 8;
ne = 12;
nf = 6;
