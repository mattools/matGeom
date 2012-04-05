function varargout = drawSphericalTriangle(sphere, p1, p2, p3, varargin)
%DRAWSPHERICALTRIANGLE Draw a triangle on a sphere
%
%   drawSphericalTriangle(SPHERE, PT1, PT2, PT3);
%
%   See also
%   drawSphere, fillSphericalTriangle, drawSphericalPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 22/02/2005
%

%   HISTORY
%   27/06/2007 manage spheres other than origin
%   30/10/2008 replace intersectPlaneLine by intersectLinePlane

% extract data of the sphere
ori = sphere(:, 1:3);

% extract direction vectors for each point
v1  = normalizeVector3d(p1 - ori);
v2  = normalizeVector3d(p2 - ori);
v3  = normalizeVector3d(p3 - ori);

h1 = drawSphericalEdge(sphere, [v1 v2], varargin{:});
h2 = drawSphericalEdge(sphere, [v2 v3], varargin{:});
h3 = drawSphericalEdge(sphere, [v3 v1], varargin{:});

if nargout > 0
    varargout = {h1, h2, h3};
end