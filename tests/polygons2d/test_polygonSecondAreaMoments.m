function test_suite = test_polygonSecondAreaMoments
%TEST_POLYGONSECONDAREAMOMENTS Tests for polygonSecondAreaMoments.m
%
%   Example
%       runtests('test_polygonSecondAreaMoments.m')
%
%   References
%       https://en.wikipedia.org/wiki/List_of_second_moments_of_area
%       https://wp.optics.arizona.edu/optomech/wp-content/uploads/
%           sites/53/2016/10/OPTI_222_W61.pdf
%

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2022-12-21, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2022

test_suite = functiontests(localfunctions);

function testCircle(testCase)
r = randi([1 100]);
circle = circleToPolygon([0 0 r], round(2*pi*r*1e2));

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(circle);
Ixx_exp = pi/4*r^4;
Iyy_exp = Ixx_exp;
Ixy_exp = 0;

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',3*1e-1);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',3*1e-1);
testCase.assertEqual(Ixy, Ixy_exp, 'AbsTol',1e-1);


function testAnnulus(testCase)
r2 = randi([50 100]);
r1 = r2 - randi([1 49]);
outerCircle = closePolygon(circleToPolygon([0 0 r2], round(2*pi*r2*1e2)));
innerCircle = flipud(closePolygon(circleToPolygon([0 0 r1], round(2*pi*r1*1e2))));
annulus = [outerCircle; innerCircle];

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(annulus);
Ixx_exp = pi/4*(r2^4-r1^4);
Iyy_exp = Ixx_exp;
Ixy_exp = 0;

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',2*1e-1);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',2*1e-1);
testCase.assertEqual(Ixy, Ixy_exp, 'AbsTol',1e-1);


function testCircularSector(testCase)
r = randi([1 100]);
circle = circleToPolygon([0 0 r] , round(2*pi*r*1e2));
theta = (pi/2-0.2)*rand+0.1;
xPosLine = reverseLine(createLine(theta/2));
xNegLine = createLine(-theta/2);

semiCircle = closePolygon(clipPolygonHP(circle, xPosLine));
circularSector = closePolygon(clipPolygonHP(semiCircle, xNegLine));

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(circularSector); %#ok<ASGLU> 
Ixx_exp = (theta-sin(theta))*r^4/8;
% Iyy_exp = ?;
% Ixy_exp = ?;

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',1e-1);


function testCenteredSemiCircle(testCase)
r = randi([1 100]);
circle = circleToPolygon([0 0 r], round(2*pi*r*1e2));
semiCircle = closePolygon(clipPolygonHP(circle, [0 0 1 0]));
centeredSemiCircle = semiCircle - polygonCentroid(semiCircle);

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(centeredSemiCircle); %#ok<ASGLU> 
Ixx_exp = (pi/8-8/(9*pi))*r^4;
Iyy_exp = pi/8*r^4;
% Ixy_exp = ?

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',2*1e-1);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',2*1e-1);


function testSemiCircle(testCase)
r = randi([1 100]);
circle = circleToPolygon([0 0 r], round(2*pi*r*1e2));
semiCircle = closePolygon(clipPolygonHP(circle, [0 0 1 0]));

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(semiCircle); %#ok<ASGLU> 
Ixx_exp = pi/8*r^4;
Iyy_exp = Ixx_exp;
% Ixy_exp = ?

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',2*1e-1);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',2*1e-1);


function testQuarterCircle(testCase)
r = randi([1 100]);
circle = circleToPolygon([0 0 r], round(2*pi*r*1e2));
semiCircle = closePolygon(clipPolygonHP(circle, [0 0 1 0]));
quarterCircle = closePolygon(clipPolygonHP(semiCircle, [0 0 0 -1]));

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(quarterCircle);
Ixx_exp = pi/16*r^4;
Iyy_exp = pi/16*r^4;
Ixy_exp = r^4/8;

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',1e-1);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',1e-1);
testCase.assertEqual(Ixy, Ixy_exp, 'AbsTol',1e-1);


function testCenteredQuarterCircle(testCase)
r = randi([1 100]);
circle = circleToPolygon([0 0 r], round(2*pi*r*1e2));
semiCircle = closePolygon(clipPolygonHP(circle, [0 0 1 0]));
quarterCircle = closePolygon(clipPolygonHP(semiCircle, [0 0 0 -1]));
centeredQuarterCircle = quarterCircle - polygonCentroid(quarterCircle);

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(centeredQuarterCircle); %#ok<ASGLU> 
Ixx_exp = (pi/16-4/(9*pi))*r^4;
Iyy_exp = Ixx_exp;
% Ixy_exp = ?;

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',1e-1);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',1e-1);


function testEllipse(testCase)
a = randi([51 100]);
b = randi([1 50]);
ellipse = ellipseToPolygon([0 0 a b], 4*a*sqrt(1-b^2/a^2)*1e2);

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(ellipse);
Ixx_exp = pi/4*a*b^3;
Iyy_exp = pi/4*a^3*b;
Ixy_exp = 0;

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',6*1e-1);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',6*1e-1);
testCase.assertEqual(Ixy, Ixy_exp, 'AbsTol',1e-1);


function testRectangle(testCase)
b = randi([51 100]);
h = randi([1 50]);
rectangle = [0 0; b 0; b h; 0 h];

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(rectangle);
Ixx_exp = b*h^3/3;
Iyy_exp = b^3*h/3;
Ixy_exp = b^2*h^2/4;

testCase.assertEqual(Ixx, Ixx_exp);
testCase.assertEqual(Iyy, Iyy_exp);
testCase.assertEqual(Ixy, Ixy_exp);


function testCenteredRectangle(testCase)
b = randi([51 100]);
h = randi([1 50]);
centeredRectangle = [b/2 -h/2; b/2 h/2; -b/2 h/2; -b/2 -h/2];

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(centeredRectangle);
Ixx_exp = b*h^3/12;
Iyy_exp = b^3*h/12;
Ixy_exp = 0;

testCase.assertEqual(Ixx, Ixx_exp);
testCase.assertEqual(Iyy, Iyy_exp);
testCase.assertEqual(Ixy, Ixy_exp);


function testHollowRectangle(testCase)
b = randi([51 100]);
h = randi([10 50]);
b1 = b - randi([10 20]);
h1 = h - randi([1 8]);
outerRectangle = [b/2 -h/2; b/2 h/2; -b/2 h/2; -b/2 -h/2];
innerRectangle = [-b1/2 -h1/2; -b1/2 h1/2; b1/2 h1/2; b1/2 -h1/2];
hollowRectangle = [closePolygon(outerRectangle); closePolygon(innerRectangle)];

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(hollowRectangle);
Ixx_exp = (b*h^3 - b1*h1^3)/12;
Iyy_exp = (b^3*h - b1^3*h1)/12;
Ixy_exp = 0;

testCase.assertEqual(Ixx, Ixx_exp);
testCase.assertEqual(Iyy, Iyy_exp);
testCase.assertEqual(Ixy, Ixy_exp);


function testCenteredTriangle(testCase)
b = randi([51 100]);
h = randi([51 100]);
a = randi([1 25]);
triangle = [0 0; b 0; a h];
centeredTriangle = triangle - polygonCentroid(triangle);

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(centeredTriangle);
Ixx_exp = b*h^3/36;
Iyy_exp = (b^3*h-b^2*h*a+b*h*a^2)/36;
Ixy_exp = -b*h^2/72*(b-2*a);

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',1e-8);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',1e-8);
testCase.assertEqual(Ixy, Ixy_exp, 'AbsTol',1e-8);


function testTriangle(testCase)
b = randi([51 100]);
h = randi([51 100]);
a = randi([1 25]);
triangle = [0 0; b 0; a h];

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(triangle);
Ixx_exp = b*h^3/12;
Iyy_exp = (b^3*h+b^2*h*a+b*h*a^2)/12;
Ixy_exp = b*h^2/24*(b+2*a);

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',1e-8);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',1e-8);
testCase.assertEqual(Ixy, Ixy_exp, 'AbsTol',1e-8);


function testlSection(testCase)
L = randi([51 100]);
t = randi([1 25]);
lSection = [0 0; L 0; L t; t t; t L; 0 L];
lSection = lSection - polygonCentroid(lSection);

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(lSection);
Ixx_exp = (t*(5*L^2-5*L*t+t^2)*(L^2-L*t+t^2))/(12*(2*L-t));
Iyy_exp = Ixx_exp;
Ixy_exp = (L^2*t*(L-t)^2)/(4*(t-2*L));

testCase.assertEqual(Ixx, Ixx_exp, 'AbsTol',1e-8);
testCase.assertEqual(Iyy, Iyy_exp, 'AbsTol',1e-8);
testCase.assertEqual(Ixy, Ixy_exp, 'AbsTol',1e-8);

