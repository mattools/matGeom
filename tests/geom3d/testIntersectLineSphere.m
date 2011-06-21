function varargout = testIntersectLineSphere(varargin) %#ok<STOUT>
%TESTINTERSECTLINESPHERE  One-line description here, please.
%
%   output = testIntersectLineSphere(input)
%
%   Example
%   testIntersectLineSphere
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-06-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

initTestSuite;

function testOx %#ok<*DEFNU>

center = [10 20 30];
radius = 50;

line = [center 6 0 0];

inter = intersectLineSphere(line, [center radius]);

exp = [...
    center(1)-radius center(2) center(3); ... 
    center(1)+radius center(2) center(3)];
assertElementsAlmostEqual(exp, inter);


function testOy

center = [10 20 30];
radius = 50;

line = [center 0 6 0];

inter = intersectLineSphere(line, [center radius]);

exp = [...
    center(1) center(2)-radius center(3); ... 
    center(1) center(2)+radius center(3)];
assertElementsAlmostEqual(exp, inter);


function testOz

center = [10 20 30];
radius = 50;

line = [center 0 0 6];

inter = intersectLineSphere(line, [center radius]);

exp = [...
    center(1) center(2) center(3)-radius; ... 
    center(1) center(2) center(3)+radius];
assertElementsAlmostEqual(exp, inter);
