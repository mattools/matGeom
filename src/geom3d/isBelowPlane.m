function below = isBelowPlane(point, varargin)
%ISBELOWPLANE Test whether a point is below or above a plane
%
%   BELOW = isBelowPlane(POINT, PLANE)
%   where POINT is given as coordinate row vector [XP YP ZP], and PLANE is
%   given as a row containing initial point and 2 direction vectors, 
%   return TRUE if POINT lie below PLANE.
%
%   Example
%   isBelowPlane([1 1 1], createPlane([1 2 3], [1 1 1]))
%   ans =
%       1
%   isBelowPlane([3 3 3], createPlane([1 2 3], [1 1 1]))
%   ans =
%       0
%
%   See also
%   planes3d, points3d, linePosition3d, planePosition
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-01-05
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

if length(varargin)==1
    plane = varargin{1};
elseif length(varargin)==2
    plane = createPlane(varargin{1}, varargin{2});
end

% ensure same dimension for parameters
if size(point, 1)==1
    point = repmat(point, [size(plane, 1) 1]);
end
if size(plane, 1)==1
    plane = repmat(plane, [size(point, 1) 1]);
end
    
% compute position of point projected on 3D line corresponding to plane
% normal, and returns true for points locatd below the plane (pos<=0).
below = linePosition3d(point, [plane(:, 1:3) planeNormal(plane)]) <= 0;
