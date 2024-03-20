function planes3d(varargin)
%PLANES3D Description of functions operating on 3D planes.
%
%   Planes are represented by a 3D point (the plane origin) and 2 direction
%   vectors, which should not be colinear.
%   PLANE = [X0 Y0 Z0  DX1 DY1 DZ1  DX2 DY2 DZ2];
%
%   See also 
%   createPlane, normalizePlane, medianPlane, planeNormal, parallelPlane
%   distancePointPlane, projPointOnPlane, planePosition, isBelowPlane
%   intersectPlanes, intersectLinePlane, intersectEdgePlane
%   dihedralAngle, planesBisector, polyhedronSlice, fitPlane, drawPlane3d
%   clipConvexPolyhedronByPlane, clipPlane, transformPlane3d, isPlane
%   clipMeshByPlane
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2008-10-13, using Matlab 7.4.0.287 (R2007a)
% Copyright 2008-2023 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas

help('planes3d');
