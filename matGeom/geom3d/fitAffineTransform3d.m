function trans = fitAffineTransform3d(pts1, pts2)
%FITAFFINETRANSFORM3D Fit an affine transform using two point sets.
%
%   TRANS = fitAffineTransform3d(PTS1, PTS2)
%
%   Example
%     N = 50;
%     pts = rand(N, 3)*10;
%     trans = createRotationOx([5 4 3], pi/4);
%     pts2 = transformPoint3d(pts, trans);
%     pts3 = pts2 + randn(N, 3)*2;
%     fitted = fitAffineTransform3d(pts, pts2);
%   
%
%   See also
%     transforms3d, transformPoint3d, transformVector3d,
%     registerPoints3dAffine
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2009-07-31,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRA - Cepia Software Platform.


% number of points 
N = size(pts1, 1);
if size(pts2, 1) ~= N
    error('Requires the same number of points for both arrays');
end

% main matrix of the problem
tmp = [pts1(:,1) pts1(:,2) pts1(:,3) ones(N,1)];
A = [...
    tmp zeros(N, 8) ; ...
    zeros(N, 4) tmp zeros(N, 4) ; ...
    zeros(N, 8) tmp ];

% conditions initialisations
B = [pts2(:,1) ; pts2(:,2) ; pts2(:,3)];

% compute coefficients using least square
coefs = A\B;

% format to a matrix
trans = [coefs(1:4)' ; coefs(5:8)'; coefs(9:12)'; 0 0 0 1];
