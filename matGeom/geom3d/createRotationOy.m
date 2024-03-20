function trans = createRotationOy(varargin)
%CREATEROTATIONOY Create the 4x4 matrix of a 3D rotation around y-axis.
%
%   TRANS = createRotationOy(THETA);
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
%   TRANS = createRotationOy(ORIGIN, THETA);
%   TRANS = createRotationOy(X0, Y0, Z0, THETA);
%   Also specifies origin of rotation. The result is similar as performing
%   translation(-X0, -Y0, -Z0), rotation, and translation(X0, Y0, Z0).
%
%
%   See also 
%   transforms3d, transformPoint3d, createRotationOx, createRotationOz
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-02-18
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

% default values
dx = 0;
dy = 0;
dz = 0;
theta = 0;

% get input values
if length(varargin) == 1
    % only one argument -> rotation angle
    theta = varargin{1};
    
elseif length(varargin) == 2
    % origin point (as array) and angle
    var = varargin{1};
    dx = var(1);
    dy = var(2);
    dz = var(3);
    theta = varargin{2};
    
elseif length(varargin) == 3
    % origin (x and y) and angle
    dx = varargin{1};
    dy = varargin{2};
    dz = 0;
    theta = varargin{3};
    
elseif length(varargin) == 4
    % origin (x and y) and angle
    dx = varargin{1};
    dy = varargin{2};
    dz = varargin{3};
    theta = varargin{4};
end

% compute coefs
cot = cos(theta);
sit = sin(theta);

% create transformation
trans = [...
    cot  0  sit  0;...
    0    1    0  0;...
    -sit 0  cot  0;...
    0    0    0  1];

% add the translation part
t = [1 0 0 dx;0 1 0 dy;0 0 1 dz;0 0 0 1];
trans = t * trans / t;
