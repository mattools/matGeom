function poly2 = clipPolygonByPlane3d(poly, plane, varargin)
%CLIPPOLYGONBYPLANE3D clip a 3d polygon by a plane.
%
%   POLY2 = clipPolygonByPlane3d(POLY, PLANE)
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
%     pol3d2 = clipPolygonByPlane3d(pol3d, plane);
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
%
%   See also 
%   poygons3d, intersectLinePolygon3d

% ------
% Author: David Legland, oqilipo 
% E-mail: david.legland@inrae.fr
% Created: 2005-08-02
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

parser = inputParser;
addRequired(parser, 'poly', @isPolygon3d)
addRequired(parser, 'plane', @isPlane)
addOptional(parser,'tolerance',1e-14, ...
    @(x) validateattributes(x,{'numeric'},{'scalar','>',0,'<',1}))
parse(parser, poly, plane, varargin{:});
TOL = parser.Results.tolerance;

[pol, inputFormat] = parsePolygon(poly, 'repetition');

% Check if the polygon's plane is the same as the clipping plane
[~, dist] = planePosition(unique(pol,'rows'), plane);
if all(dist<TOL)
        poly2 = poly;
    return;
end

% Check for each point of the polygon if it's above or below the plane.
below = isBelowPlane(pol, plane);

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
basisTFM = createBasisTransform3d('global', fitPlane(pol));
poly2d = transformPoint3d(pol, basisTFM);

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

% The input format of the polygon is not clear if it only contains one 
% repetition of the first and last point. It can be 'repetiton' or 'nan'.
% In this case the last point is removed.
if size(poly2, 1) - size(unique(poly2, 'rows'), 1) == 1 && ...
        isequal(poly2(1,:), poly2(end,:))
    poly2(end,:) = [];
end

end