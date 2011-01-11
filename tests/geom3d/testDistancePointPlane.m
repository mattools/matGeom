function test_suite = testDistancePointPlane(varargin) %#ok<STOUT>
%testDistancePointPlane  One-line description here, please.
%   output = testDistancePointPlane(input)
%
%   Example
%   testDistancePointPlane
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-06-19,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.

initTestSuite;

function testAboveOx %#ok<*DEFNU>
% plane orthogonal to Ox axis
point   = [10 10 10];
plane   = createPlane([0 0 0], [1 0 0]);
distTh  = 10;
dist    = distancePointPlane(point, plane);
assertElementsAlmostEqual(distTh, dist);

function testAboveOy
% plane orthogonal to Ox axis
point   = [10 10 10];
plane   = createPlane([0 0 0], [0 1 0]);
distTh  = 10;
dist    = distancePointPlane(point, plane);
assertElementsAlmostEqual(distTh, dist);

function testAboveOz
% plane orthogonal to Ox axis
point   = [10 10 10];
plane   = createPlane([0 0 0], [0 0 1]);
distTh  = 10;
dist    = distancePointPlane(point, plane);
assertElementsAlmostEqual(distTh, dist);


function testBelowOx
% plane orthogonal to Ox axis
point   = [0 0 0];
plane   = createPlane([10 10 10], [1 0 0]);
distTh  = -10;
dist    = distancePointPlane(point, plane);
assertElementsAlmostEqual(distTh, dist);

function testBelowOy
% plane orthogonal to Ox axis
point   = [0 0 0];
plane   = createPlane([10 10 10], [0 1 0]);
distTh  = -10;
dist    = distancePointPlane(point, plane);
assertElementsAlmostEqual(distTh, dist);

function testBelowOz
% plane orthogonal to Ox axis
point   = [0 0 0];
plane   = createPlane([10 10 10], [0 0 1]);
distTh  = -10;
dist    = distancePointPlane(point, plane);
assertElementsAlmostEqual(distTh, dist);

function testPointArray

points  = [10 0 0;10 20 30;10 10 10;10 0 20];
plane   = createPlane([0 0 0], [1 0 0]);
distTh  =  [10;10;10;10];
dist    = distancePointPlane(points, plane);
assertElementsAlmostEqual(distTh, dist);

function testPlaneArray

point   = [0 0 0];
planes  = createPlane([10 0 0;10 20 30;10 10 10;10 0 20], [1 0 0]);
distTh  =  [-10;-10;-10;-10];
dist    = distancePointPlane(point, planes);
assertElementsAlmostEqual(distTh, dist);

function testBothArray

points  = [0 0 0;0 20 30;0 10 10;0 0 20];
planes  = createPlane([10 0 0;10 20 30;10 10 10;10 0 20], [1 0 0]);
distTh  =  [-10;-10;-10;-10];
dist    = distancePointPlane(points, planes);
assertElementsAlmostEqual(distTh, dist);

