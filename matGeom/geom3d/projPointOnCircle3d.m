function point2 = projPointOnCircle3d(point, circle)
%PROJPOINTONCIRCLE3D Project a 3D point onto a 3D circle.
%
%   PT2 = projPointOnCircle3d(PT, CIRCLE).
%   Computes the projection of 3D point PT onto the 3D circle CIRCLE. 
%   
%   Point PT is a N-by-3 array, and CIRCLE is a 1-by-7 array.
%   Result PT2 is a N-by-3 array, containing coordinates of projections of
%   PT onto the circle CIRCLE. 
%
%   See also
%   projPointOnLine3d, projPointOnPlane
%
%   Source
%   https://www.geometrictools.com/Documentation/DistanceToCircle3.pdf
%
% ---------
% Author: oqilipo
% Created: 2020-10-12
% Copyright 2020
%

center = circle(1:3);
radius = circle(4);

% Compute transformation from local basis to world basis
TFM = localToGlobal3d(center, circle(5), circle(6), circle(7));

% Create circle plane
circlePlaneNormal = transformVector3d([0 0 1], TFM);
circlePlane = createPlane(center, circlePlaneNormal);

% Project point on circle plane
PTonCP = projPointOnPlane(point, circlePlane);

% Calculate vector from the projected point to the center of the circle
PTtoCenter = normalizeVector3d(circle(1:3) - PTonCP);

% Calculate final point
point2 = PTonCP + PTtoCenter.*(distancePoints3d(PTonCP, center) - radius);

% Take an arbitrary point of the circle if the point is the center of the circle
if any(all(isnan(point2),2))
    point2(all(isnan(point2),2),:) = center + normalizeVector3d(circlePlane(4:6))*radius;
end
% Take an arbitrary point of the circle if the point lies on the normal of the circle plane
if any(sum(PTtoCenter == 0,2) == 2)
    point2(sum(PTtoCenter == 0,2) == 2,:) = center + normalizeVector3d(circlePlane(4:6))*radius;
end
end