function deg = rad2deg(rad)
%RAD2DEG Convert angle from radians to degrees
%
%   Usage:
%   R = rad2deg(D)
%   convert an angle in radians to angle in degrees
%
%   Example:
%   rad2deg(pi)
%   ans =
%       180
%   rad2deg(pi/3)
%   ans =
%       60
%
%   See Also
%   angles2d, deg2rad
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 09/12/2004.
%

deg = rad*180/pi;
