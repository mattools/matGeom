function [centroid, area] = polygonCentroid3d(varargin)
%POLYGONCENTROID3D Centroid (or center of mass) of a polygon.
%
%   PTC = polygonCentroid3d(POLY)
%   Computes center of mass of a polygon defined by POLY. POLY is a N-by-3
%   array of double containing coordinates of polygon vertices. The result
%   PTC is given as a 1-by-3 numeric array.
%   The algorithm assumes (1) that the vertices of the polygon are within
%   the same plane and (2) that the planar projection of the polygon (on
%   the embedding plane) do not self-intersect.
%
%   PTC = polygonCentroid3d(VX, VY, VZ)
%   Specifies vertex coordinates as three separate arrays.
%
%   Example
%     % compute centroid of a basic polygon
%     poly = [0 0 0; 10 0 10;10 10 20;0 10 10];
%     centro = polygonCentroid3d(poly)
%     centro =
%         5.0000    5.0000    10.0000
%
%   See also 
%     polygons3d, polygonArea3d, polygonCentroid, planePosition, planePoint
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2007-09-18
% Copyright 2007-2022 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas)

if nargin == 1
    % polygon is given as a single argument
    pts = varargin{1};
elseif nargin == 3
    % polygon is given as 3 coordinate arrays
    px = varargin{1};
    py = varargin{2};
    pz = varargin{3};
    pts = [px py pz];
end

% create supporting plane
plane = fitPlane(pts);

% project points onto the plane
pts = planePosition(pts, plane);

% compute centroid in 2D
[centro2d, area] = polygonCentroid(pts);

% project back in 3D
centroid = planePoint(plane, centro2d);
