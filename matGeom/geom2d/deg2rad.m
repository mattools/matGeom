function rad = deg2rad(deg)
%DEG2RAD Convert angle from degrees to radians
%
%   Usage:
%   R = deg2rad(D)
%   convert an angle in degrees to an angle in radians.
%
%   Example
%   deg2rad(180)    % gives pi
%   ans = 
%       3.1416
%   deg2rad(60)     % gives pi/3
%   ans =
%       1.0472
%
%   See Also
%   angles2d, rad2deg
%   
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 09/12/2004.
%

rad = deg*pi/180;
