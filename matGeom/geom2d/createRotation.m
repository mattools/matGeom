function trans = createRotation(varargin)
%CREATEROTATION Create the 3*3 matrix of a rotation
%
%   TRANS = createRotation(THETA);
%   Returns the rotation corresponding to angle THETA (in radians)
%   The returned matrix has the form :
%   [cos(theta) -sin(theta)  0]
%   [sin(theta)  cos(theta)  0]
%   [0           0           1]
%
%   TRANS = createRotation(POINT, THETA);
%   TRANS = createRotation(X0, Y0, THETA);
%   Also specifies origin of rotation. The result is similar as performing
%   translation(-X0, -Y0), rotation(THETA), and translation(X0, Y0).
%
%
%   See also:
%   transforms2d, transformPoint, createRotation90, createTranslation
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2004.
%

%   HISTORY
%   22/04/2009: rename as createRotation

% default values
cx = 0;
cy = 0;
theta = 0;

% get input values
if length(varargin)==1
    % only angle
    theta = varargin{1};
elseif length(varargin)==2
    % origin point (as array) and angle
    var = varargin{1};
    cx = var(1);
    cy = var(2);
    theta = varargin{2};
elseif length(varargin)==3
    % origin (x and y) and angle
    cx = varargin{1};
    cy = varargin{2};
    theta = varargin{3};
end

% compute coefs
cot = cos(theta);
sit = sin(theta);
tx =  cy*sit - cx*cot + cx;
ty = -cy*cot - cx*sit + cy;

% create transformation matrix
trans = [cot -sit tx; sit cot ty; 0 0 1];
