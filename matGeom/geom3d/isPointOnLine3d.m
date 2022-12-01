function b = isPointOnLine3d(point, line, varargin)
%ISPOINTONLINE3D Test if a 3D point belongs to a 3D line.
%
%   B = isPointOnLine3d(POINT, LINE)
%   with POINT being [xp yp zp], and LINE being [x0 y0 z0 dx dy dz].
%   Returns 1 if point lies on the line, 0 otherwise.
%
%   If POINT is an N-by-3 array of points, B is a N-by-1 array of booleans.
%
%   If LINE is a N-by-6 array of lines, B is a N-by-1 array of booleans.
%
%   B = isPointOnLine3d(POINT, LINE, TOL)
%   Specifies the tolerance used for testing location on 3D line.
%
%   See also 
%   lines3d, distancePointLine3d, linePosition3d, isPointOnLine
%

% ------
% Author: David Legland 
% E-mail: david.legland@inra.fr
% Created: 2003-10-31
% Copyright 2003-2022 INRA - TPV URPOI - BIA IMASTE

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% size of inputs
np = size(point,1);
nl = size(line, 1);

if np == 1 || nl == 1 || np == nl
    % test if lines are colinear, using norm of the cross product
    b = bsxfun(@rdivide, vectorNorm3d( ...
        crossProduct3d(bsxfun(@minus, line(:,1:3), point), line(:,4:6))), ...
        vectorNorm3d(line(:,4:6))) < tol;
else
    % same test, but after reshaping arrays to manage difference of
    % dimensionality
    point = reshape(point, [np 1 3]);
    line = reshape(line, [1 nl 6]);
    b = bsxfun(@rdivide, vectorNorm3d( ...
        cross(bsxfun(@minus, line(:,:,1:3), point), line(ones(1,np),:,4:6), 3)), ...
        vectorNorm3d(line(:,:,4:6))) < tol;
end
