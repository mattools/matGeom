function intersects = intersectRayPolygon(ray, poly, varargin)
%INTERSECTRAYPOLYGON Intersection points between a ray and a polygon
%
%   P = intersectRayPolygon(RAY, POLY)
%   Returns the intersection points of the ray RAY with polygon POLY. 
%   RAY is a 1x4 array containing parametric representation of the ray
%   (in the form [x0 y0 dx dy], see createRay for details). 
%   POLY is a Nx2 array containing coordinate of polygon vertices
%   
%   P = intersectRayPolygon(RAY, POLY, TOL)
%   Specifies the tolerance for geometric tests. Default is 1e-14.
%
%   See also
%   rays2d, polygons2d, intersectLinePolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 26/01/2010


%   HISTORY
%   2010/01/26 creation from intersectLinePolygon


% compute intersections with supporting line
intersects = intersectLinePolygon(ray, poly, varargin{:});

% compute position of intersects on the supporting line
pos = linePosition(intersects, ray);

% keep only intersects with position>0
intersects(pos<0, :) = [];
