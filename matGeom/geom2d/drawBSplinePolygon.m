function varargout = drawBSplinePolygon(poly, varargin)
%DRAWBSPLINEPOLYGON  Draw a smooth curve by interpolating polygon vertices.
%
%   drawBSplinePolygon(POLY)
%   POLY is a N-by-2 numeric array containing vertex coordinates of the
%   control polygon. At least four points are expected.
%
%   Example
%     poly = [10 10; 30 10; 40 20;30 40;10 30];
%     figure; hold on; axis equal; axis([0 50 0 50]);
%     drawPolyline(poly);
%     drawBSplinePolygon(poly, 'r');
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-04-01,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE.

% number of subdivisions per edge
n = 20;

beta3_0 = @(u) (1 - u).^3 / 6;
beta3_1 = @(u) (3*u.^3 - 6*u.^2 + 4) / 6;
beta3_2 = @(u) (-3*u.^3 + 3*u.^2 +3*u + 1) / 6;
beta3_3 = @(u) u.^3 / 6;

% initialize parameterization of single edge
t = linspace(0, 1, n+1)';
t(end) = [];

% allocate array
nv = size(poly, 1);
np = nv * n;
pts = zeros(np, 2);

for i = 1:nv
    iv0 = mod(i + nv - 2, nv) + 1;
    iv1 = mod(i + nv - 1, nv) + 1;
    iv2 = mod(i + nv, nv) + 1;
    iv3 = mod(i + nv + 1, nv) + 1;

    coords = poly(iv0,:) .* beta3_0(t);
    coords = coords + poly(iv1,:) .* beta3_1(t);
    coords = coords + poly(iv2,:) .* beta3_2(t);
    coords = coords + poly(iv3,:) .* beta3_3(t);

    inds =  (1:n) + (i-1)*n;
    pts(inds, :) = coords;

end

h = drawPolygon(pts, varargin{:});

if nargout > 0
    varargout{1} = h;
end