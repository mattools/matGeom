function theta = dihedralAngle(plane1, plane2)
%DIHEDRALANGLE compute dihedral angle between 2 planes
%
%   THETA = dihedralAngle(PLANE1, PLANE2)
%   PLANE1 and PLANE2 are plane representations given in the following
%   format:
%   [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   THETA is the angle between the two vectors given by plane normals,
%   given between 0 and PI.
%
%   References
%   http://en.wikipedia.org/wiki/Dihedral_angle
%   http://mathworld.wolfram.com/DihedralAngle.html
%
%   See also:
%   planes3d, lines3d, angles3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 21/02/2005.
%

%   HISTORY
%   19/06/2009 change convention for dihedral angle


% compute normlized vectors of plane normals
n1 = normalizeVector3d(planeNormal(plane1));
n2 = normalizeVector3d(planeNormal(plane2));

% compute dihedral angle
theta = acos(dot(n1, n2, 2));
