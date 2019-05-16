function varargout = drawSphericalPolygon(sphere, poly, varargin)
%DRAWSPHERICALPOLYGON  Draw a spherical polygon.
%
%   output = drawSphericalPolygon(input)
%
%   Example
%   drawSphericalPolygon
%
%   See also
%
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

    h(i) = drawSphericalEdge(sphere, [v1 v2], varargin{:});
end


if nargout > 0
    varargout = {h};
end
