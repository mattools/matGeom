function res = polynomialTransform2d(pts, coeffs)
%POLYNOMIALTRANSFORM2D Apply a polynomial transform to a set of points
%
%   RES = polynomialTransform2d(PTS, COEFFS)
%   Transforms the input points PTS given as a N-by-2 array of coordinates
%   using the polynomial transform defined by PARAMS.
%   PARAMS given as [a0 b0 a1 b1 ... an bn]
%
%   Example
%   coeffs = [0 0  1 0  0 1   0.1 0  0 0  0 0.1];
%       %     cte   x    y     x^2   x*y   y^2
%   pts = rand(200, 2) * 2 - 1;
%   pts2 = polynomialTransform2d(pts, coeffs);
%   figure; hold on;
%   drawPoint(pts);
%   drawPoint(pts2, 'g');
%
%   See also
%     transformPoint, fitPolynomialTransform2d

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-09-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.

x = pts(:,1);
y = pts(:,2);
nPoints = length(x);


xCoeffs = coeffs(1:2:end);
yCoeffs = coeffs(2:2:end);
nCoeffs = length(xCoeffs);

% allocate memory for result
x2 = zeros(nPoints, 1);
y2 = zeros(nPoints, 1);

% degree from coefficient number
degree = sqrt(9/4 - 4*(1 - nCoeffs)/2) - 1.5;

% iterate over degrees
iCoeff = 0;
for iDegree = 0:degree
    
    % iterate over binomial coefficients of a given degree
    for k = 0:iDegree
        iCoeff = iCoeff + 1;
        tmp = power(x, iDegree-k) .* power(y, k);
        x2 = x2 + xCoeffs(iCoeff) .* tmp;
        y2 = y2 + yCoeffs(iCoeff) .* tmp;
    end
end

res = [x2 y2];
