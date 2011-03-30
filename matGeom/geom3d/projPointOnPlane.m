function point = projPointOnPlane(point, plane)
%PROJPOINTONPLANE Return the orthogonal projection of a point on a plane
%
%   PT2 = projPointOnPlane(PT1, PLANE);
%   Compute the (orthogonal) projection of point PT1 onto the line PLANE.
%   
%   Function works also for multiple points and planes. In this case, it
%   returns multiple points.
%   Point PT1 is a [N*3] array, and PLANE is a [N*9] array (see createPlane
%   for details). Result PT2 is a [N*3] array, containing coordinates of
%   orthogonal projections of PT1 onto planes PLANE.
%
%   See also:
%   planes3d, points3d, planePosition, intersectLinePlane
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   21/08/2006: debug support for multiple points or planes

if size(point, 1)==1
    point = repmat(point, [size(plane, 1) 1]);
elseif size(plane, 1)==1
    plane = repmat(plane, [size(point, 1) 1]);
elseif size(plane, 1) ~= size(point, 1)
    error('projPointOnPlane: size of inputs differ');
end

n = planeNormal(plane);
line = [point n];
point = intersectLinePlane(line, plane);
