function curve = BSplinePolygon(poly, nDiv)
%BSPLINEPOLYGON Interpolate polygon vertices using cubic BSpline.
%
%   CURVE = BSplinePolygon(POLY, NDIV)
%   POLY is a N-by-2 numeric array containing vertex coordinates of the
%   control polygon. NDOC is the number of subdivision of each polygon
%   edge. The resulting curve in an array of point coordinates with N*NDIV
%   coordinates.
%
%   Example
%     poly = [10 10; 30 10; 40 20; 30 40;20 20;10 30];
%     curve = BSplinePolygon(poly, 20);
%     figure; hold on; axis equal; axis([0 50 0 50]);
%     drawPolygon(poly);
%     drawPolygon(curve, 'LineWidth', 2, 'Color', 'r');
%
%   See also
%     drawBSplinePolygon, cubicBezierToPolyline
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-04-02,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE.

if nargin == 1
    nDiv = 20;
end

% The four BSpline basis functions
beta3_0 = @(u) (1 - u).^3 / 6;
beta3_1 = @(u) (3*u.^3 - 6*u.^2 + 4) / 6;
beta3_2 = @(u) (-3*u.^3 + 3*u.^2 +3*u + 1) / 6;
beta3_3 = @(u) u.^3 / 6;

% initialize parameterization of single edge
t = linspace(0, 1, nDiv+1)';
t(end) = [];

% allocate result array
nv = size(poly, 1);
np = nv * nDiv;
curve = zeros(np, 2);

for i = 1:nv
    iv0 = mod(i + nv - 2, nv) + 1;
    iv1 = mod(i + nv - 1, nv) + 1;
    iv2 = mod(i + nv, nv) + 1;
    iv3 = mod(i + nv + 1, nv) + 1;

    coords = poly(iv0,:) .* beta3_0(t);
    coords = coords + poly(iv1,:) .* beta3_1(t);
    coords = coords + poly(iv2,:) .* beta3_2(t);
    coords = coords + poly(iv3,:) .* beta3_3(t);

    inds =  (1:nDiv) + (i-1)*nDiv;
    curve(inds, :) = coords;
end
