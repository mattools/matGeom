function varargout = drawSphericalPolygon(varargin)
%DRAWSPHERICALPOLYGON Draw a spherical polygon.
%
%   output = drawSphericalPolygon(input)
%
%   Example
%     % Draw a non convex spherical polygon on the surface of a sphere
%     sphere = [0 0 0 1];
%     poly = [0 -1 0;0 0 1; [-1 0 1]/sqrt(2); [-1 -1 1]/sqrt(3); [-1 -1 0]/sqrt(2)];
%     figure; hold on; axis equal; drawSphere([0 0 0 1]); view(3);
%     drawSphericalPolygon(sphere, poly, 'LineWidth', 2, 'color', 'b')
%
%   See also
%     drawSphere, drawSphericalTriangle, drawSphericalEdge
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2012-02-09,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


% Check if axes handle is specified
if isAxisHandle(varargin{1})
    hAx = varargin{1};
    varargin(1) = [];
else
    hAx = gca;
end

sphere = varargin{1};
poly = varargin{2};
varargin(1:2) = [];

nv = size(poly, 1);

h = zeros(nv, 1);
for i = 1:nv
    v1 = poly(i, :);
    v2 = poly(mod(i, nv) + 1, :);

    h(i) = drawSphericalEdge(hAx, sphere, [v1 v2], varargin{:});
end


if nargout > 0
    varargout = {h};
end
