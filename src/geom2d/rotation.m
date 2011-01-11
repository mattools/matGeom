function trans = rotation(varargin)
%ROTATION return 3*3 matrix of a rotation
%
%   TRANS = rotation(THETA);
%   Returns the rotation corresponding to angle THETA (in radians)
%   The returned matrix has the form :
%   [cos(theta) -sin(theta)  0]
%   [sin(theta)  cos(theta)  0]
%   [0           0           1]
%
%   TRANS = rotation(POINT, THETA);
%   TRANS = rotation(X0, Y0, THETA);
%   Also specifies origin of rotation. The result is similar as performing
%   translation(-dx, -dy), rotation, and translation(dx, dy).
%
%
%   See also:
%   transforms2d, transformPoint, translation
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2004.
%

%   HISTORY
%   22/04/2009: copy to createRotation and deprecate

% deprecation warning
warning('geom2d:deprecated', ...
    '''rotation'' is deprecated, use ''createRotation'' instead');

% call current implementation
trans = createRotation(varargin{:});