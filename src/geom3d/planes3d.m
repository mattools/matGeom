function planes3d(varargin)
%PLANES3D Description of functions operating on 3D planes
%
%   Planes are represented by a 3D point (the plane origin) and 2 direction
%   vectors, which should not be colinear.
%   PLANE = [X0 Y0 Z0 DX1 DY1 DZ1 DX2 DY2 DZ2];
%
%   See also
%   createPlane, medianPlane, normalizePlane
%   planeNormal, planePosition, dihedralAngle
%   intersectPlanes, projPointOnPlane, isBelowPlane
%   intersectLinePlane, intersectEdgePlane, distancePointPlane
%   drawPlane3d
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

help('planes3d');