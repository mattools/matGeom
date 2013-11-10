function trans = fitAffineTransform2d(pts1, pts2)
%FITAFFINETRANSFORM2D Fit an affine transform using two point sets
%   TRANS = fitAffineTransform2d(PTS1, PTS2)
%
%   Example
%   N = 10;
%   pts = rand(N, 2)*10;
%   trans = createRotation(3, 4, pi/4);
%   pts2 = transformPoint(pts, trans);
%   pts3 = pts2 + randn(N, 2)*2;
%   fitted = fitAffineTransform2d(pts, pts2);
%   
%
%   See also
%     transforms2d, transformPoint, transformVector,
%     fitPolynomialTransform2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2009-07-31,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.


% number of points 
N = size(pts1, 1);

% main matrix of the problem
A = [...
    pts1(:,1) pts1(:,2) ones(N,1) zeros(N, 3) ; ...
    zeros(N, 3) pts1(:,1) pts1(:,2) ones(N,1)  ];

% conditions initialisations
B = [pts2(:,1) ; pts2(:,2)];

% compute coefficients using least square
coefs = A\B;

% format to a matrix
trans = [coefs(1:3)' ; coefs(4:6)'; 0 0 1];
