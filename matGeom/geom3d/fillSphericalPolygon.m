function varargout = fillSphericalPolygon(sphere, poly, germ)
%FILLSPHERICALPOLYGON  Fill a spherical polygon.
%
%   fillSphericalPolygon(SPHERE, POLY, GERM)
%
%
%   Example
%   fillSphericalPolygon
%
%   See also
%   drawSphericalPolygon, fillSphericalTriangle, drawSphere
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

nv = size(poly, 1);

h = zeros(nv, 1);
for i = 1:nv
    v1 = poly(i, :);
    v2 = poly(mod(i, nv) + 1, :);

    h(i) = fillSphericalTriangle(sphere, germ, v1, v2);
end


if nargout > 0
    varargout = {h};
end
