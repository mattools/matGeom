function test_suite = testCreateSoccerBall(varargin) %#ok<STOUT>
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

initTestSuite;


function testCreation %#ok<*DEFNU>

createSoccerBall();


function testVEFCreation

[v e f] = createSoccerBall();
assertTrue(~isempty(v));
assertTrue(~isempty(e));
assertTrue(~isempty(f));

[nv ne nf] = getMeshElementsNumber;
assertEqual([nv 3], size(v));
assertEqual([ne 2], size(e));
assertEqual(nf, length(f));


function testVFCreation

[v f] = createSoccerBall();
assertTrue(~isempty(v));
assertTrue(~isempty(f));

[nv ne nf] = getMeshElementsNumber; %#ok<ASGLU>
assertEqual([nv 3], size(v));
assertEqual(nf, length(f));


function testMeshCreation

mesh = createSoccerBall();
assertTrue(isstruct(mesh));
assertTrue(isfield(mesh, 'vertices'));
assertTrue(isfield(mesh, 'edges'));
assertTrue(isfield(mesh, 'faces'));

[nv ne nf] = getMeshElementsNumber;
assertEqual([nv 3], size(mesh.vertices));
assertEqual([ne 2], size(mesh.edges));
assertEqual(nf, length(mesh.faces));


function [nv ne nf] = getMeshElementsNumber

nv = 60;
ne = 90;
nf = 32;
