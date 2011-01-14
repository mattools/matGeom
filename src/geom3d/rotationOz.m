function trans = rotationOz(varargin)
%ROTATIONOZ return 4x4 matrix of a rotation around z-axis
%
%   TRANS = rotationOz(THETA);
%   Returns the transform matrix corresponding to a rotation by the angle
%   THETA (in radians) around the Oz axis. A rotation by an angle of PI/2
%   would transform the vector [1 0 0] into the vector [0 1 0].
%
%   The returned matrix has the form:
%   [cos(THETA) -sin(THETA)  0  0]
%   [sin(THETA)  cos(THETA)  0  0]
%   [    0           0       1  0]
%   [    0           0       0  1]
%
%   TRANS = rotationOz(ORIGIN, THETA);
%   TRANS = rotationOz(X0, Y0, Z0, THETA);
%   Also specifies origin of rotation. The result is similar as performing
%   translation(-X0, -Y0, -Z0), rotation, and translation(X0, Y0, Z0).
%
%
%   See also:
%   transforms3d, transformPoint3d, rotationOx, rotationOy
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2004.
%

%   HISTORY
%   2008/11/24 changed convention for angle
%   30/04/2009 deprecate: use createRotationOz instead

% deprecation warning
warning('geom3d:deprecated', ...
    [mfilename ' is deprecated, use ''createRotationOz'' instead']);

% call current implementation
trans = createRotationOz(varargin{:});
