function res = transformEllipse(elli, transfo)
%TRANSFORMELLIPSE Apply an affine transformation to an ellipse.
%
%   ELLI2 = transformEllipse(ELLI, TRANSFO)
%
%   Example
%     % apply an arbitrary transform to a simple ellipse
%     elli = [5 4 3 2 0];
%     rot = createRotation(pi/6);
%     sca = createScaling([2.5 1.5]);
%     tra = createTranslation([4 3]);
%     transfo = sca * rot * tra;
%     elli2 = transformEllipse(elli, transfo);
%     % display original and transformed ellipses
%     figure; hold on; axis equal; axis([0 20 0 20]);
%     drawEllipse(elli, 'k');
%     drawEllipse(elli2, 'b');
%     % Compare with transform on polygonal approximation
%     poly = ellipseToPolygon(elli, 100);
%     drawPolygon(transformPoint(poly, transfo), 'm');
%
%   Reference
%   https://math.stackexchange.com/questions/3076317/what-is-the-equation-for-an-ellipse-in-standard-form-after-an-arbitrary-matrix-t
%
%   See also
%     ellipses2d, transforms2d, transformPoint

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2022-09-05, using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE - BIA Research Unit - BIBS Platform (Nantes)

% first extract coefficients of cartesian representation
coeffs = ellipseCartesianCoefficients(elli);

% writing the matrix of the general conic equation x^t * Q * x = 0
Q = [...
     coeffs(1)   coeffs(2)/2  coeffs(4)/2; ...
    coeffs(2)/2   coeffs(3)   coeffs(5)/2; ...
    coeffs(4)/2  coeffs(5)/2   coeffs(6)];

% compute the matrix form of the transformed ellipse
Minv = inv(transfo);
Q2 = Minv' * Q * Minv;

coeffs2 = [Q2(1,1) 2*Q2(1,2) Q2(2,2) 2*Q2(1,3) 2*Q2(2,3) Q2(3,3)];
res = createEllipse('CartesianCoefficients', coeffs2);
