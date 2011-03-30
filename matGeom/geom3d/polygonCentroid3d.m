function pt = polygonCentroid3d(varargin)
%POLYGONCENTROID3D Centroid (or center of mass) of a polygon
%
%   PT = polygonCentroid3d(POLY)
%   Computes center of mass of a polygon defined by POLY. POLY is a N-by-3
%   array of double containing coordinates of polygon vertices.
%
%   PT = polygonCentroid3d(VX, VY, VZ)
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
% e-mail: david.legland@jouy.inra.fr
% Created: 2007-09-18
% Copyright 2007 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


if nargin==1
    pts = varargin{1};
elseif nargin==2
    px = varargin{1};
    py = varargin{2};
    pz = varargin{3};
    pts = [px py pz];
end

% create support plane
plane   = createPlane(pts(1:3, :));

% project points onto the plane
pts = planePosition(pts, plane);

centro = polygonCentroid(pts);

pt = planePoint(plane, centro);

