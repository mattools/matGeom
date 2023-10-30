function test_suite = test_polygonCentroid
%TEST_POLYGONCENTROID  Test case for the file polygonCentroid
%
%   Test case for the file polygonCentroid

%   Example
%   test_polygonCentroid
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

test_suite = functiontests(localfunctions);

function test_Square(testCase) %#ok<*DEFNU>
% Test call of function without argument
square = [0 0;10 0;10 10;0 10];

centro = polygonCentroid(square);
testCase.assertEqual([5 5], centro);

function test_SquareMultiVertices(testCase)
% Test call of function without argument
square = [0 0;10 0;10 10;10 10;0 10;0 0];

centro = polygonCentroid(square);
testCase.assertEqual([5 5], centro);

function test_Lozenge(testCase)
% Test call of function without argument
poly = [10 10;20 20;10 30;0 20];

centro = polygonCentroid(poly);
testCase.assertEqual([10 20], centro);

function test_BearingBlock(testCase)
% Source: https://faculty.mercer.edu/jenkins_he/documents/Centroids.pdf
%     	  Sample Problem 5.1

width = 120;
r1 = width/2;
semiCircle = circleToPolygon([0 0 r1], round(2*pi*r1*1e3));
semiCircle(semiCircle(:,2)<0,:) = [];
rHight = 80;
semiCircle = semiCircle + [width/2 rHight];
tHight = 60;
outside = [width 0; semiCircle; 0 -tHight];
r2=40;
circle = circleToPolygon([0 0 r2], round(2*pi*r2*1e3));
circle = circle + [width/2 rHight];

poly = {outside; flipud(circle)};
[centroid, area, Sx, Sy] = polygonCentroid(poly);
% figure('Color','w'); axis equal;
% drawPolygon(poly)

% Excepected (exp) values
% Areas
aR = width*rHight; % Rectangle
aT = 1/2*width*tHight; % Triangle
aSC = 1/2*pi*r1^2; % Semicircle
aC = -pi*r2^2; % Circle

area_exp = aR + aT + aSC + aC;
Sy_exp = (width/2*aR + 1/3*width*aT + width/2*aSC + width/2*aC);
Sx_exp = (rHight/2*aR - 1/3*tHight*aT + (rHight+4*r1/3/pi)*aSC + rHight*aC);

centroid_exp(1,1) = Sy_exp/area_exp;
centroid_exp(1,2) = Sx_exp/area_exp;

absTol = 1e-4;
testCase.assertEqual(centroid, centroid_exp, 'AbsTol',absTol);
testCase.assertEqual(area, area_exp, 'AbsTol',absTol);
testCase.assertEqual(Sx, Sx_exp, 'AbsTol',absTol);
testCase.assertEqual(Sy, Sy_exp, 'AbsTol',absTol);