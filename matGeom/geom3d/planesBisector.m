function bis = planesBisector(plane1, plane2)
%PLANESBISECTOR Bisector plane between two other planes.
% 
%   BIS = planesBisector(PLANE1, PLANE2);
%   Returns the planes that contains the intersection line between PLANE1 
%   and PLANE2 and that bisect the dihedral angle of PLANE1 and PLANE2. 
%   Note that computing the bisector of PLANE2 and PLANE1 (in that order) 
%   returns the same plane but with opposite orientation.
%
%   Example
%     % Draw two planes together with their bisector
%     pl1 = createPlane([3 4 5], [1 2 3]);
%     pl2 = createPlane([3 4 5], [2 -3 4]);
%     % compute bisector
%     bis = planesBisector(pl1, pl2);
%     % setup display
%     figure; hold on; axis([0 10 0 10 0 10]);
%     set(gcf, 'renderer', 'opengl')
%     view(3);
%     % draw the planes
%     drawPlane3d(pl1, 'g');
%     drawPlane3d(pl2, 'g');
%     drawPlane3d(bis, 'b');
%
%   See also
%   planes3d, dihedralAngle, intersectPlanes
%

% ------
% Author: Ben X. Kang
% E-mail: N/A
% Created: ?
% Copyright ?

% Let the two planes be defined by equations
% 
%  a1*x + b1*y + c1*z + d1 = 0
% 
% and
% 
%  a2*x + b2*y + c2*z + d2 = 0
% 
% in which vectors [a1,b1,c1] and [a2,b2,c2] are normalized to be of unit
% length (a^2+b^2+c^2 = 1). Then 
% 
%  (a1+a2)*x + (b1+b2)*y + (c1+c2)*z + (d1+d2) = 0
% 
% is the equation of the desired plane which bisects the dihedral angle
% between the two planes.  These coefficients cannot be all zero because
% the two given planes are not parallel.
% 
% Notice that there is a second solution to this problem
% 
%  (a1-a2)*x + (b1-b2)*y + (c1-c2)*z + (d1-d2) = 0
% 
% which also is a valid plane and orthogonal to the first solution. One of
% these planes bisects the acute dihedral angle, and the other the
% supplementary obtuse dihedral angle, between the two given planes.   


p1 = plane1(1:3);			% a point on the plane
n1 = planeNormal(plane1);	% the normal of the plane

p2 = plane2(1:3);
n2 = planeNormal(plane2);

if ~isequal(p1(1:3), p2(1:3))
	L = intersectPlanes(plane1, plane2);	% intersection of the given two planes
	pt = L(1:3);							% a point on the line intersection
else
	pt = p1(1:3);
end

% use column-wise vector
bis = createPlane(pt, n1 - n2);
