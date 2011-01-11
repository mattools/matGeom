function test_suite = testCreateCube(varargin) %#ok<STOUT>
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
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

initTestSuite;


function testCreation %#ok<*DEFNU>

createCube();


function testVEFCreation

[v e f] = createCube();
assertTrue(~isempty(v));
assertTrue(~isempty(e));
assertTrue(~isempty(f));

[nv ne nf] = getMeshElementsNumber;
assertEqual([nv 3], size(v));
assertEqual([ne 2], size(e));
assertEqual(nf, length(f));


function testVFCreation

[v f] = createCube();
assertTrue(~isempty(v));
assertTrue(~isempty(f));

[nv ne nf] = getMeshElementsNumber; %#ok<ASGLU>
assertEqual([nv 3], size(v));
assertEqual(nf, length(f));


function testMeshCreation

mesh = createCube();
assertTrue(isstruct(mesh));
assertTrue(isfield(mesh, 'vertices'));
assertTrue(isfield(mesh, 'edges'));
assertTrue(isfield(mesh, 'faces'));

[nv ne nf] = getMeshElementsNumber;
assertEqual([nv 3], size(mesh.vertices));
assertEqual([ne 2], size(mesh.edges));
assertEqual(nf, length(mesh.faces));


function testFacesOutwards

[v e f] = createCube(); %#ok<ASGLU>

centro = centroid(v);
fc  = faceCentroids(v, f);
fc2 = createVector(centro, fc);
n   = faceNormal(v, f);

assertEqual(size(n), size(fc2));

dp = dot(fc2, n, 2);

assertTrue(sum(dp <= 0) == 0);


function [nv ne nf] = getMeshElementsNumber

nv = 8;
ne = 12;
nf = 6;
