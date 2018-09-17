function trans = rotationOy(varargin)
%ROTATIONOY return 4x4 matrix of a rotation around y-axis
%
%   TRANS = rotationOy(THETA);
%   Returns the transform matrix corresponding to a rotation by the angle
%   THETA (in radians) around the Oy axis. A rotation by an angle of PI/2
%   would transform the vector [0 0 1] into the vector [1 0 0].
%
%   The returned matrix has the form:
%   [ cos(THETA)  0  sin(THETA)  0 ]
%   [    0        1       0      0 ]
%   [-sin(THETA)  0  cos(THETA)  0 ]
%   [    0        0       0      1 ]
%
%   TRANS = rotationOy(ORIGIN, THETA);
%   TRANS = rotationOy(X0, Y0, Z0, THETA);
%   Also specifies origin of rotation. The result is similar as performing
%   translation(-X0, -Y0, -Z0), rotation, and translation(X0, Y0, Z0).
%
%
%   See also:
%   transforms3d, transformPoint3d, rotationOx, rotationOz
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   2008/11/24 changed convention for angle
%   30/04/2009 deprecate: use createRotationOy instead

% deprecation warning
warning('geom3d:deprecated', ...
    [mfilename ' is deprecated, use ''createRotationOy'' instead']);

% call current implementation
trans = createRotationOy(varargin{:});
