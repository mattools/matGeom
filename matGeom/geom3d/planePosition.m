function pos = planePosition(point, plane)
%PLANEPOSITION Compute position of a point on a plane
%
%   PT2 = planePosition(POINT, PLANE)
%   POINT has format [X Y Z], and plane has format
%   [X0 Y0 Z0  DX1 DY1 DZ1  DX2 DY2 DZ2], where :
%   - (X0, Y0, Z0) is a point belonging to the plane
%   - (DX1, DY1, DZ1) is a first direction vector
%   - (DX2, DY2, DZ2) is a second direction vector
%
%   Result PT2 has the form [XP YP], with [XP YP] coordinate of the point
%   in the coordinate system of the plane.
%
%   
%   CAUTION:
%   WORKS ONLY FOR PLANES WITH ORTHOGONAL DIRECTION VECTORS
%
%   See also:
%   planes3d, points3d, planePoint
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005.
%

%   HISTORY
%   24/11/2005 add support for multiple input

% unify size of data
if size(point, 1)~=size(plane, 1)
    if size(point, 1)==1
        point = repmat(point, [size(plane, 1) 1]);
    elseif size(plane, 1)==1
        plane = repmat(plane, [size(point, 1) 1]);
    else
        error('point and plane do not have the same dimension');
    end
end


p0 = plane(:, 1:3);
d1 = plane(:, 4:6);
d2 = plane(:, 7:9);

s = dot(point-p0, d1, 2) ./ vectorNorm3d(d1);
t = dot(point-p0, d2, 2) ./ vectorNorm3d(d2);

pos = [s t];

