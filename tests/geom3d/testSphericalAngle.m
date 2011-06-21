function test_suite = testSphericalAngle(varargin) %#ok<STOUT>
%TESTSPHERICALANGLE  One-line description here, please.
%
%   output = testSphericalAngle(input)
%
%   Example
%   testSphericalAngle
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

function testP2At100 %#ok<*DEFNU>

p2 = [1 0 0];
p1 = [0 1 0];
p3 = [0 0 1];

alpha = sphericalAngle(p1, p2, p3);

assertEqual(pi/2, alpha);

% try in the other direction
alpha = sphericalAngle(p3, p2, p1);

assertEqual(3*pi/2, alpha);
