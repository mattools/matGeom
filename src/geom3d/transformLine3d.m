function res = transformLine3d(line, trans)
%TRANSFORMLINE3D  transform a 3D line with a 3D affine transform
%   output = transformLine3d(input)
%
%   Example
%   transformLine3d
%
%   See also:
%   lines3d, transforms3d, transformPoint3d, transformVector3d
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2008-11-25,    using Matlab 7.7.0.471 (R2008b)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

res = [...
    transformPoint3d(line(:, 1:3), trans) ...   % transform origin point
    transformVector3d(line(:,4:6), trans)];     % transform direction vect.