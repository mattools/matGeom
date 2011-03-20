function theta = dihedralAngle(plane1, plane2)
%DIHEDRALANGLE Compute dihedral angle between 2 planes
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

% HISTORY
% 2009-06-19 change convention for dihedral angle
% 2011-03-20 improve computation precision

% compute plane normals
v1 = planeNormal(plane1);
v2 = planeNormal(plane2);

% number of vectors
n1 = size(v1, 1);
n2 = size(v2, 1);

% ensures vectors have same dimension
if n1~=n2
    if n1==1
        v1 = repmat(v1, [n2 1]);
    elseif n2==1
        v2 = repmat(v2, [n1 1]);
    else
        error('Arguments V1 and V2 must have the same size');
    end
end

% compute dihedral angle(s)
theta = atan2(vectorNorm3d(cross(v1, v2, 2)), dot(v1, v2, 2));

% % equivalent to:
% n1 = normalizeVector3d(planeNormal(plane1));
% n2 = normalizeVector3d(planeNormal(plane2));
% theta = acos(dot(n1, n2, 2));

