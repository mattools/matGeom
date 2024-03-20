function trans = createRotation(varargin)
%CREATEROTATION Create the 3*3 matrix of a rotation.
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
%   Example
%     % apply a rotation on a polygon
%     poly = [0 0; 30 0;30 10;10 10;10 20;0 20];
%     trans = createRotation([10 20], pi/6);
%     polyT = transformPoint(poly, trans);
%     % display the original and the rotated polygons
%     figure; hold on; axis equal; axis([-10 40 -10 40]);
%     drawPolygon(poly, 'k');
%     drawPolygon(polyT, 'b');
%
%   See also 
%   transforms2d, transformPoint, createRotation90, createTranslation
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2004-04-06
% Copyright 2004-2023 INRA - TPV URPOI - BIA IMASTE

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
