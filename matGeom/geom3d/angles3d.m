function angles3d(varargin)
%ANGLES3D Conventions for manipulating angles in 3D.
%
%   Angle units
%   The library uses both radians and degrees angles:
%   * results of angle computation between shapes usually returns angles in
%   radians.
%   * row-vector representations of 3D shapes use angles in degrees. This
%   makes it easier to interpret and to save.
%
%   Spherical angles
%   Spherical angles can be defined by 2 angles:
%   * THETA, the colatitude, representing angle with Oz axis (between 0 and
%       PI)
%   * PHI, the azimut, representing angle with Ox axis of horizontal
%       projection of the direction (between 0 and 2*PI)
%   Spherical coordinates can be represented by THETA, PHI, and the
%   distance RHO to the origin.
%   Discussion on choice for convention can be found at:
%   http://www.physics.oregonstate.edu/bridge/papers/spherical.pdf
%
%   Euler angles
%   Some functions for creating rotations use Euler angles. They follow the
%   "ZYX" convention in the global reference system, that is equivalent to
%   the "XYZ" convention in a local reference system. 
%   Euler angles are given by a triplet of angles [PHI THETA PSI] that
%   represents the succession of 3 rotations: 
%   * rotation around X by angle PSI    ("roll")
%   * rotation around Y by angle THETA  ("pitch")
%   * rotation around Z by angle PHI    ("yaw")
%   Within MatGeom, euler angles are given in degrees. The functions that
%   use euler angles use the keyword 'Euler' in their name.
%
%   Shape orientation
%   Row-vector representations of 3D shapes (ellipsoids, cylinders...) can
%   often be decomposed into position, size, and orientation parts. Two
%   different conventions are used to represent the orientation, depending
%   on the type of the shape:  
%   * elongated or "solid" shapes (ellipsoids, cuboids, cylinders...)
%   consider two angles for representing the spherical angle of the main
%   axis of the shape, and one angle to represent the orientation of the
%   shape around that axis. This results in a "yaw-pitch-roll" triplet of
%   angles (PHI, THETA, PSI), corresponding to XYZ Euler angles.
%   * flat objects (3D ellipses or discs), consider two angles for
%   representing the direction of the normal angle of the supporting plane,
%   and one angle for representing the rotation around the normal axis. 
%   This convention is also used in astronomy. This results in a triplet 
%   (THETA, PHI, PSI) of three angles: THETA is the colatitude, PHI is the
%   azimut, and PSI is the rotation angle around axis. This corresponds to
%   Euler angles with the "ZYZ" convention.
%   Orientation angles of 3D shapes are always given in degrees.
%
%   Oriented angles
%   Contrary to the plane, 3D angles are not oriented. The computation of
%   angles between lines or between planes are therefore comprised between
%   0 and PI (rather than 0 and 2*PI in 2D).
%
%   See also 
%   cart2sph2, sph2cart2, cart2sph2d, sph2cart2d, cart2cyl, cyl2cart
%   anglePoints3d, angleSort3d, sphericalAngle, randomAngle3d
%   dihedralAngle, polygon3dNormalAngle, eulerAnglesToRotation3d
%   rotation3dAxisAndAngle, rotation3dToEulerAngles
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2008-10-13, using Matlab 7.4.0.287 (R2007a)
% Copyright 2008-2024 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas
