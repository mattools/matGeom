function poly2 = clipPolygon3dHP(poly, plane, varargin)
%CLIPPOLYGON3DHP clip a 3d polygon by a plane.
%
%   POLY2 = clipPolygon3dHP(POLY, PLANE)
%   The 3d polygon POLY is clipped by the PLANE. The result POLY2:
%    - Represents the part of the polygon below the plane if the plane
%      intersects the polygon.
%    - Is the same as POLY if the polygon is below the plane and the plane 
%      does not intersect the polygon.
%    - Is an empty 3d polygon [0x3] if the polygon is above the plane and 
%      the plane does not intersect the polygon.
%
%   Example
%     % 2d poly
%     pol = [6	7	6	6	5	4	3	2	2	1	2	2	6 ...
%            NaN  3	3	4	5	5	3	NaN	4	5	5;
%            4	4	5	6	6	7	6	6	4	2	2	2	1 ...
%    	     NaN  4	5	5	4	4	3	NaN	3	2	3]';
%     % Transform into 3d polygon
%     phi=-360+720*rand;
%     theta=-360+720*rand;
%     psi=-360+720*rand;
%     pol3d = transformPolygon3d(pol,eulerAnglesToRotation3d(phi, theta, psi));
%     plane = [polygonCentroid3d(pol3d) rand(1,6)];
%     % Clip polygon 
%     pol3d2 = clipPolygon3dHP(pol3d, plane);
%     % Draw results
%     figure; hold on; axis equal; view(3)
%     drawPolygon3d(pol3d, 'linewidth', 2, 'color', 'y');
%     drawPlane3d(plane)
%     drawPolygon3d(pol3d2, 'linewidth', 2, 'color', 'b');
%     drawArrow3d(polygonCentroid3d(pol3d), ...
%         normalizeVector3d(planeNormal(plane))*3,'g')
%   
%   Todo
%   * If plane is same as polygon plane?
%   * Rename this function to 'clipPolygon3d'
%
%   See also 
%   poygons3d, intersectLinePolygon3d

% ------
% Author: David Legland, oqilipo 
% E-mail: david.legland@inrae.fr
% Created: 2005-08-02
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

p = inputParser;
addRequired(p, 'poly', @isPolygon3d)
addRequired(p, 'plane', @isPlane)
parse(p, poly, plane, varargin{:});

[poly, inputFormat] = parsePolygon(poly, 'repetition');

% Check for each point of the polygon if it's above or below the plane.
below = isBelowPlane(poly, plane);

% In the case of a polygon totally over the plane, return empty array
if sum(below) == 0
    poly2 = zeros(0, 3);
    return;
end

% In the case of a polygon totally below the plane, return original polygon
if sum(~below) == 0
    poly2 = poly;
    return;
end

% Transform into 2D
basisTFM = createBasisTransform3d('global', fitPlane(poly));
poly2d = transformPoint3d(poly, basisTFM);

% Intersection line between polygon and plane
itsLine = intersectPlanes([0 0 0 1 0 0 0 1 0], ...
    transformPlane3d(plane, basisTFM));
poly2dNan = parsePolygon(poly2d,'nan');

% Clip the 2d polygon by the intersection line
poly22d = clipPolygonHP(poly2dNan(:,1:2), [itsLine(1:2) itsLine(4:5)],...
    'method', 'polyshape');

% Transform the 2d polygon back to 3d
poly2 = transformPolygon3d(poly22d, inv(basisTFM));
poly2 = parsePolygon(poly2, inputFormat);

end