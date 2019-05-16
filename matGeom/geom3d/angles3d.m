function angles3d(varargin)
%ANGLES3D Conventions for manipulating angles in 3D.
%
%   The library uses both radians and degrees angles;
%   Results of angle computation between shapes usually returns angles in
%   radians.
%   Representation of 3D shapes use angles in degrees (easier to manipulate
%   and to save). 
%
%   Contrary to the plane, there are no oriented angles in 3D. Angles
%   between lines or between planes are comprised between 0 and PI.
%
%   Spherical angles
%   Spherical angles are defined by 2 angles:
%   * THETA, the colatitude, representing angle with Oz axis (between 0 and
%       PI)
%   * PHI, the azimut, representing angle with Ox axis of horizontal
%       projection of the direction (between 0 and 2*PI)
%
%   Spherical coordinates can be represented by THETA, PHI, and the
%   distance RHO to the origin.
%
%   Euler angles
%   Some functions for creating rotations use Euler angles. They follow the
%   ZYX convention in the global reference system, that is eqivalent to the
%   XYZ convention ine a local reference system. 
%   Euler angles are given by a triplet of angles [PHI THETA PSI] that
%   represents the succession of 3 rotations: 
%   * rotation around X by angle PSI    ("roll")
%   * rotation around Y by angle THETA  ("pitch")
%   * rotation around Z by angle PHI    ("yaw")
%
%   In this library, euler angles are given in degrees. The functions that
%   use euler angles use the keyword 'Euler' in their name.
%
%
%   See also
%   cart2sph2, sph2cart2, cart2sph2d, sph2cart2d
%   anglePoints3d, angleSort3d, sphericalAngle, randomAngle3d
%   dihedralAngle, polygon3dNormalAngle, eulerAnglesToRotation3d
%   rotation3dAxisAndAngle, rotation3dToEulerAngles
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
