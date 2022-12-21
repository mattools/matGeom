function test_suite = test_polygonSecondAreaMoments
%TEST_POLYGONSECONDAREAMOMENTS Tests for polygonSecondAreaMoments.m
%
%   Example
%       runtests('test_polygonSecondAreaMoments.m')
%
%   Reference
%       https://en.wikipedia.org/wiki/List_of_second_moments_of_area
%

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2022-12-21, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2022

test_suite = functiontests(localfunctions);

function testCircle(testCase)
r = randi([1 100]);
circle = circleToPolygon([0 0 r] , round(2*pi*r*1e3));

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(circle);
Ixx_exp = pi/4*r^4;
Iyy_exp = pi/4*r^4;
Ixy_exp = 0;

testCase.assertEqual(Ixx_exp, Ixx, 'AbsTol',1e-2);
testCase.assertEqual(Iyy_exp, Iyy, 'AbsTol',1e-2);
testCase.assertEqual(Ixy_exp, Ixy, 'AbsTol',1e-2);


function testAnnulus(testCase)
r2 = randi([50 100]);
r1 = r2 - randi([1 49]);
outerCircle = closePolygon(circleToPolygon([0 0 r2] , round(2*pi*r2*1e3)));
innerCircle = flipud(closePolygon(circleToPolygon([0 0 r1] , round(2*pi*r1*1e3))));
annulus = [outerCircle; innerCircle];

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(annulus);
Ixx_exp = pi/4*(r2^4-r1^4);
Iyy_exp = pi/4*(r2^4-r1^4);
Ixy_exp = 0;

testCase.assertEqual(Ixx_exp, Ixx, 'AbsTol',1e-2);
testCase.assertEqual(Iyy_exp, Iyy, 'AbsTol',1e-2);
testCase.assertEqual(Ixy_exp, Ixy, 'AbsTol',1e-2);


function testRectangle(testCase)
b = randi([51 100]);
h = randi([1 50]);
rectangle = [b/2 -h/2; b/2 h/2; -b/2 h/2; -b/2 -h/2];

[Ixx, Iyy, Ixy] = polygonSecondAreaMoments(rectangle);
Ixx_exp = b*h^3/12;
Iyy_exp = b^3*h/12;
Ixy_exp = 0;

testCase.assertEqual(Ixx_exp, Ixx);
testCase.assertEqual(Iyy_exp, Iyy);
testCase.assertEqual(Ixy_exp, Ixy);


function testHollowRectangle(testCase) %#ok<*DEFNU>
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

testCase.assertEqual(Ixx_exp, Ixx);
testCase.assertEqual(Iyy_exp, Iyy);
testCase.assertEqual(Ixy_exp, Ixy);


function poly = closePolygon(poly)

if ~isequal(poly(1,:),poly(end,:))
    poly(end+1,:) = poly(1,:);
end