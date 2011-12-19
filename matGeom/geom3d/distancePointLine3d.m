function d = distancePointLine3d(point, line)
%DISTANCEPOINTLINE3D Euclidean distance between 3D point and line
%
%   D = distancePointLine3d(POINT, LINE);
%   Returns the distance between point POINT and the line LINE, given as:
%   POINT : [x0 y0 z0]
%   LINE  : [x0 y0 z0 dx dy dz]
%   D     : (positive) scalar  
%   
%   See also:
%   lines3d, points3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 23/05/2005.
%

%   HISTORY
%   15/01/2007 unify size of input data
%   31/01/2007 typo in data formatting, and replace norm by vecnorm3d
%   12/12/2010 changed to bsxfun implementation - Sven Holcombe

% cf. Mathworld (distance point line 3d)  for formula
d = bsxfun(@rdivide, vectorNorm3d( ...
        vectorCross3d(line(:,4:6), bsxfun(@minus, line(:,1:3), point)) ), ...
        vectorNorm3d(line(:,4:6)));
