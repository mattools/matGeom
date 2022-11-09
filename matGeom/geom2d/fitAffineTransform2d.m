function trans = fitAffineTransform2d(ref, src)
%FITAFFINETRANSFORM2D Compute the affine transform that best register two point sets.
%
%   TRANSFO = fitAffineTransform2d(REF, SRC)
%   Returns the affine transform matrix that minimizes the distance between
%   the reference point set REF and the point set SRC after transformation.
%   Both REF and SRC must by N-by-2 arrays with the same number of rows,
%   and the points must be in correspondence.
%   The function minimizes the sum of the squared distances:
%   CRIT = sum(distancePoints(REF, transformPoint(PTS, TRANSFO)).^2);
%
%   Example
%     % computes the transform the register two ellipses
%     % create the reference poitn set
%     elli = [50 50 40 20 30];
%     poly = resamplePolygonByLength(ellipseToPolygon(elli, 200), 5);
%     figure; axis equal; axis([0 100 0 100]); hold on;
%     drawPoint(poly, 'kx')
%     % create the point set to fit on the reference
%     trans0 = createRotation([20 60], -pi/8);
%     poly2 = transformPoint(poly, trans0);
%     poly2 = poly2 + randn(size(poly)) * 2;
%     drawPoint(poly2, 'b+');
%     % compute the transform that project poly2 onto poly.
%     transfo = fitAffineTransform2d(poly, poly2);
%     poly2t = transformPoint(poly2, transfo);
%     drawPoint(poly2t, 'mo')
%     legend('Reference', 'Initial', 'Transformed');
%
%   See also
%     transforms2d, transformPoint, transformVector,
%     fitPolynomialTransform2d, registerICP, fitAffineTransform3d
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2009-07-31,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2009 INRAE - Cepia Software Platform.

% check number of points are equal
N = size(src, 1);
if size(ref, 1) ~= N
    error('Requires the same number of points for both arrays');
end

% main matrix of the problem
A = [...
    src(:,1) src(:,2) ones(N,1) zeros(N, 3) ; ...
    zeros(N, 3) src(:,1) src(:,2) ones(N,1)  ];

% conditions initialisations
B = [ref(:,1) ; ref(:,2)];

% compute coefficients using least square
coefs = A\B;

% format to a matrix
trans = [coefs(1:3)' ; coefs(4:6)'; 0 0 1];
