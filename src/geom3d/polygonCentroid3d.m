function pt = polygonCentroid3d(varargin)
%POLYGONCENTROID3D compute centroid (center of mass) of a polygon
%
%   PT = polygonCentroid3d(POINTS)
%   PT = polygonCentroid3d(PTX, PTY, PTZ)
%   Computes center of mass of a polygon defined by POINTS. POINTS is a
%   [N*2] array of double.
%
%
%   See also:
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

