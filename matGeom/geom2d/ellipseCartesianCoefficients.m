function coeffs = ellipseCartesianCoefficients(elli)
%ELLIPSECARTESIANCOEFFICIENTS Cartesian coefficients of an ellipse.
%
%   COEFFS = ellipseCartesianCoefficients(ELLI)
%   Computes the cartesian coefficients of the ellipse ELLI, given by:
%     COEFFS = [A B C D E F] 
%   such that the points on the ellipse follow:
%     A*X^2 + B*X*Y + C*Y^2 + D*X + E*Y + F = 0
%
%   Example
%     elli = [30 20 40 20 30];
%     coeffs = ellipseCartesianCoefficients(elli)
%     elli2 = createEllipse(coeffs)
%     elli2 =
%        30.0000   20.0000   40.0000   20.0000   30.0000
%
%   See also
%     ellipses2d, createEllipse, equivalentEllipse
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-09-05,    using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE.

% retrieve ellipse center and squared radiusses
xc = elli(1);
yc = elli(2);
a2 = elli(3)^2;
b2 = elli(4)^2;

% pre-compute trigonometric functions (angle is in degrees)
cot = cos(elli(5) * pi / 180);
sit = sin(elli(5) * pi / 180);

% identification of each parameter
A = a2 * sit * sit + b2 * cot * cot;
B = 2 * (b2 - a2) * sit * cot;
C = a2 * cot * cot + b2 * sit * sit;
D = - 2 * A * xc - B * yc;
E = - B * xc - 2 * C * yc;
F = A * xc * xc + B * xc * yc + C * yc * yc - a2 * b2;

% concatenate into a single row vector
coeffs = [A B C D E F];
