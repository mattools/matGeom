function spheres(varargin)
%SPHERES Description of functions operating on 3D spheres.
%
%   Spheres are represented by their center and their radius:
%   S = [xc yc zc r];
%
%   An ellipsoid is defined by:
%   ELL = [XC YC ZC  A B C  PHI THETA PSI]
%   where [XC YC ZY] is the center, [A B C] are length of semi-axes (in
%   decreasing order), and [PHI THETA PSI] are euler angles representing
%   the ellipsoid orientation.
%
%   See also
%   createSphere, equivalentEllipsoid
%   intersectLineSphere, intersectPlaneSphere, sphericalVoronoiDomain
%   drawSphere, drawEllipsoid, fillSphericalTriangle, fillSphericalPolygon
%   drawSphericalEdge, drawSphericalTriangle, drawSphericalPolygon
%   

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
