function poly2 = resamplePolyline(poly, n)
%RESAMPLEPOLYLINE Distribute N points equally spaced on a polyline
%
%   RES = resamplePolyline(POLY, N)
%   Resample the input polyline POLY such that the resulting polyline RES
%   has N points. All points of RES belong to the initial polyline, but are
%   not necessarily vertices.
%
%   Example
%     poly = [0 10;0 0;20 0];
%     figure; drawPolyline(poly, 'b');
%     poly2 = resamplePolyline(poly, 10);
%     hold on; 
%     drawPolyline(poly2, 'bo');
%     axis equal; axis([-10 30 -10 20]);
%
%   See also
%     polygons2d, drawPolyline, resamplePolygon
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-09,    using Matlab 7.9.0.529 (R2009b)
% Copyrightf 2011 INRA - Cepia Software Platform.

% parametrisation of the curve
s = parametrize(poly);

% distribute N points equally spaced
Lmax = s(end);
pos = linspace(0, Lmax, n);

poly2 = zeros(n, size(poly, 2));
for i = 1:n
    % index of surrounding vertices before and after
    ind0 = find(s <= pos(i), 1, 'last');
    ind1 = find(s >= pos(i), 1, 'first');
    
    if ind0 == ind1
        % get position of a vertex in input polyline
        poly2(i, :) = poly(ind0, :);
        continue;
    end
    
    % position of surrounding vertices
    pt0 = poly(ind0, :);
    pt1 = poly(ind1, :);
    
    % weights associated to each neighbor
    l0 = pos(i) - s(ind0);
    l1 = s(ind1) - pos(i);
    
    % linear interpolation of neighbor positions
    poly2(i, :) = (pt0 * l1 + pt1 * l0) / (l0 + l1);
end
