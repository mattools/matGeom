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

% unify sizes of data
if size(point, 1) == 1;     % one plane possible many lines
    point = repmat(point, size(line, 1), 1);
elseif size(line,1) == 1;   % one line and many planes
    line = repmat(line, size(point, 1), 1);
elseif (size(point,1) ~= size(line, 1)) ; % N planes and M lines, not allowed for now.
    error('Not the same number of points and of lines');
end


% cf. Mathworld (distance point line 3d)  for formula
d = vectorNorm3d(cross(line(:,4:6), (line(:,1:3)-point))) ./ ...
    vectorNorm3d(line(:,4:6));
