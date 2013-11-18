function coeffs = fitPolynomialTransform2d(pts, ptsRef, degree)
%FITPOLYNOMIALTRANSFORM2D Coefficients of polynomial transform between two point sets
%
%   COEFFS = fitPolynomialTransform2d(PTS, PTSREF, DEGREE)
%
%   Example
%  
%   See also
%     polynomialTransform2d, fitAffineTransform2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2013-11-05,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2013 INRA - Cepia Software Platform.


%% Extract data

% ensure degree is valid
if nargin < 3
    degree = 3;
end

% polygon coordinates
xi = pts(:,1);
yi = pts(:,2);
nCoords = size(pts, 1);

% check inputs have same size
if size(ptsRef, 1) ~= nCoords
    error('fitPolynomialTransform2d:sizeError', ...
        'input arrays must have same number of points');
end
    

%% compute coefficient matrix

% number of coefficients of polynomial transform
nCoeffs = prod(degree + [1 2]) / 2;

% initialize matrix
A1 = zeros(nCoords, nCoeffs);

% iterate over degrees
iCoeff = 0;
for iDegree = 0:degree
    
    % iterate over binomial coefficients of a given degree
    for k = 0:iDegree
        iCoeff = iCoeff + 1;
        A1(:, iCoeff) = ones(nCoords, 1) .* power(xi, iDegree-k) .* power(yi, k);
    end
end

% concatenate matrix for both coordinates
A = kron(A1, [1 0;0 1]);


%% solve linear system that minimizes least squares

% create the vector of expected values
b = ptsRef';
b = b(:);

% solve the system
coeffs = (A \ b)';


