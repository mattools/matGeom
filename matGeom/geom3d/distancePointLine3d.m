function d = distancePointLine3d(point, line)
%DISTANCEPOINTLINE3D Euclidean distance between 3D point and line.
%
%   D = distancePointLine3d(POINT, LINE);
%   Returns the distance between point POINT and the line LINE, given as:
%   POINT : [x0 y0 z0]
%   LINE  : [x0 y0 z0 dx dy dz]
%   D     : (positive) scalar  
%   
%   See also 
%   lines3d, isPointOnLine3d, distancePointEdge3d, projPointOnLine3d,
%   
%
%   References
%   http://mathworld.wolfram.com/Point-LineDistance3-Dimensional.html

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-05-23
% Copyright 2005-2024 INRA - TPV URPOI - BIA IMASTE

% cf. Mathworld (distance point line 3d)  for formula
d = bsxfun(@rdivide, vectorNorm3d( ...
        crossProduct3d(line(:,4:6), bsxfun(@minus, line(:,1:3), point)) ), ...
        vectorNorm3d(line(:,4:6)));
