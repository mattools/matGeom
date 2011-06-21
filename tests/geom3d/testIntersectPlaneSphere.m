function varargout = testIntersectPlaneSphere(varargin) %#ok<STOUT>
%TESTINTERSECTPLANESPHERE  One-line description here, please.
%
%   output = testIntersectPlaneSphere(input)
%
%   Example
%   testIntersectPlaneSphere
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
% Plane normal to direction [1 0 0]

center = [10 20 30];
radius = 50;
sphere = [center radius];

plane = createPlane(center, [6 0 0]);

circle = intersectPlaneSphere(plane, sphere);

exp = [center radius 90 0 0];
assertElementsAlmostEqual(exp, circle);


function testOxShifted
% Plane normal to direction [1 0 0]

center = [10 20 30];
radius = 50;
sphere = [center radius];

center2 = center + [radius/2 0 0];
plane = createPlane(center2, [6 0 0]);

circle = intersectPlaneSphere(plane, sphere);

radius2 = radius * sqrt(3) / 2;
exp = [center2 radius2 90 0 0];
assertElementsAlmostEqual(exp, circle);


function testOy
% Plane normal to direction [0 1 0]

center = [10 20 30];
radius = 50;
sphere = [center radius];

plane = createPlane(center, [0 6 0]);

circle = intersectPlaneSphere(plane, sphere);

exp = [center radius 90 90 0];
assertElementsAlmostEqual(exp, circle);


function testOyShifted
% Plane normal to direction [0 1 0]

center = [10 20 30];
radius = 50;
sphere = [center radius];

center2 = center + [0 radius/2 0];
plane = createPlane(center2, [0 6 0]);

circle = intersectPlaneSphere(plane, sphere);

radius2 = radius * sqrt(3) / 2;
exp = [center2 radius2 90 90 0];
assertElementsAlmostEqual(exp, circle);


function testOz
% Plane normal to direction [0 1 0]

center = [10 20 30];
radius = 50;
sphere = [center radius];

plane = createPlane(center, [0 0 6]);

circle = intersectPlaneSphere(plane, sphere);

exp = [center radius 0 0 0];
assertElementsAlmostEqual(exp, circle);


function testOzShifted
% Plane normal to direction [0 0 1]

center = [10 20 30];
radius = 50;
sphere = [center radius];

center2 = center + [0 0 radius/2];
plane = createPlane(center2, [0 0 6]);

circle = intersectPlaneSphere(plane, sphere);

radius2 = radius * sqrt(3) / 2;
exp = [center2 radius2 0 0 0];
assertElementsAlmostEqual(exp, circle);

