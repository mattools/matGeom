function centroid = polygonCentroid3d(varargin)
%POLYGONCENTROID3D Centroid (or center of mass) of a polygon
%
%   PTC = polygonCentroid3d(POLY)
%   Computes center of mass of a polygon defined by POLY. POLY is a N-by-3
%   array of double containing coordinates of polygon vertices.
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
%   polygons3d, polygonCentroid
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-09-18
% Copyright 2007 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


if nargin==1
    % polygon is given as a single argument
    pts = varargin{1};
    
elseif nargin==2
    % polygon is given as 3 corodinate arrays
    px = varargin{1};
    py = varargin{2};
    pz = varargin{3};
    pts = [px py pz];
end

% create supporting plane (assuming first 3 points are not colinear...)
plane = createPlane(pts(1:3, :));

% project points onto the plane
pts = planePosition(pts, plane);

% compute centroid in 2D
centro2d = polygonCentroid(pts);

% project back in 3D
centroid = planePoint(plane, centro2d);
