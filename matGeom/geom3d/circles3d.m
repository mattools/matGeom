function circles3d(varargin)
%CIRCLES3D Description of functions operating on 3D circles.
%
%   Circles are represented by a center, a radius and a 3D angle
%   representing the normal of the plane containing the circle. 
%   C = [xc yc zc R theta phi psi].
%   THETA is the colatitude of the normal, in degrees, between 0 and 180
%   PHI is the azimut of the normal, in degrees, between 0 and 360
%   PSI is the proper rotation of the circle around the normal, between 0
%       and 360 degrees
%   The parameter PSI is used to locate a point on the 3D circle.
%
%   See also
%   circle3dOrigin, circle3dPosition, circle3dPoint, intersectPlaneSphere
%   drawCircle3d, drawCircleArc3d, drawEllipse3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.
