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
%   See also: 
%   lines3d, distancePointLine3d, linePosition3d, isPointOnLine
%

% ---------
% author : David Legland 
% e-mail: david.legland@inra.fr
% INRA - TPV URPOI - BIA IMASTE
% created the 31/10/2003.
%

%   HISTORY
%   17/12/2013 create from isPointOnLine

% extract computation tolerance
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% test if lines are colinear, using norm of the cross product
b = bsxfun(@rdivide, vectorNorm3d( ...
        crossProduct3d(bsxfun(@minus, line(:,1:3), point), line(:,4:6))), ...
        vectorNorm3d(line(:,4:6))) < tol;

