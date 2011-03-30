function angles3d(varargin)
%ANGLES3D Conventions for manipulating angles in 3D
%
%   Contrary to the plane, there is no oriented angle in 3D. Angles are
%   comprised between 0 and PI.
%
%   Spherical angles
%   Spherical angles are defined by 3 angles:
%   - THETA, the colatitude, representing angle with Oz axis (between 0 and
%       PI)
%   - PHI, the azimut, representing angle with Ox axis of horizontal
%       projection of the direction (between 0 and 2*PI)
%   - PSI, which denotes the rotation around the normal direction (between
%       0 and 2*PI).
%
%   Spherical coordinates can be represented by THETA, PHI, and the
%   distance RHO to the origin.
%
%   Euler angles
%   Some functions for creating rotations use Euler Angles. They follow the
%   XYZ convention, in the sense a triplet of angles [PHI THETA PSI]
%   represent the succession of 3 rotations:
%   - rotation around X by angle PHI (roll)
%   - rotation around Y by angle THETA (pitch)
%   - rotation around Z by angle PSI (yaw)
%   The functions that use euler angles use the keyword 'Euler' it in their
%   name.
%
%
%   See also
%   cart2sph2, sph2cart2
%   anglePoints3d, angleSort3d, sphericalAngle, randomAngle3d
%   dihedralAngle, polygon3dNormalAngle, createEulerAnglesRotation
%   rotation3dAxisAndAngle, rotation3dToEulerAngles
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
