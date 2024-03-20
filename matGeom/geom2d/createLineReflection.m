function trans = createLineReflection(line)
%CREATELINEREFLECTION Create the the 3x3 matrix of a line reflection.
%
%   TRANS = createLineReflection(LINE);
%   where line is given as [x0 y0 dx dy], return the affine tansform
%   corresponding to the desired line reflection
%
%
%   See also 
%   lines2d, transforms2d, transformPoint, 
%   createTranslation, createHomothecy, createScaling

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-01-19
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

% extract line parameters
x0 = line(:,1);
y0 = line(:,2);
dx = line(:,3);
dy = line(:,4);

% normalisation coefficient of line direction vector
delta = dx*dx + dy*dy;

% compute coefficients of transform
m00 = (dx*dx - dy*dy)/delta; 
m01 = 2*dx*dy/delta; 
m02 = 2*dy*(dy*x0 - dx*y0)/delta; 
m10 = 2*dx*dy/delta; 
m11 = (dy*dy - dx*dx)/delta; 
m12 = 2*dx*(dx*y0 - dy*x0)/delta; 

% create transformation
trans = [m00 m01 m02; m10 m11 m12; 0 0 1];
