function d = distanceLines3d(line1, line2)
%DISTANCELINES3D Minimal distance between two 3D lines
%
%   D = distanceLines3d(LINE1, LINE2);
%   Returns the distance between line LINE1 and the line LINE2, given as:
%   LINE1 : [x0 y0 z0 dx dy dz] (or M-by-6 array)
%   LINE2 : [x0 y0 z0 dx dy dz] (or N-by-6 array)
%   D     : (positive) array M-by-N
%   
%   Example
%     line1 = [2 3 4 0 1 0];
%     line2 = [8 8 8 0 0 1];
%     distanceLines3d(line1, line2)
%     ans = 
%         6.0000
%
%   See also:
%   lines3d
%
%   ---------
%   author: Brandon Baker
%   created January 19, 2011
%

% number of points of each array
n1 = size(line1, 1);
n2 = size(line2, 1);

% compute difference of coordinates for each pair of point ([n1*n2] array)
v1x = repmat(line1(:,4), [1 n2]);
v1y = repmat(line1(:,5), [1 n2]);
v1z = repmat(line1(:,6), [1 n2]);
p1x = repmat(line1(:,1), [1 n2]);
p1y = repmat(line1(:,2), [1 n2]);
p1z = repmat(line1(:,3), [1 n2]);

v2x = repmat(line2(:,4)', [n1 1]);
v2y = repmat(line2(:,5)', [n1 1]);
v2z = repmat(line2(:,6)', [n1 1]);
p2x = repmat(line2(:,1)', [n1 1]);
p2y = repmat(line2(:,2)', [n1 1]);
p2z = repmat(line2(:,3)', [n1 1]);

% This calculates distance for each set of lines

vcross = cross([v1x(:) v1y(:) v1z(:)], [v2x(:) v2y(:) v2z(:)]);

num = ([p1x(:) p1y(:) p1z(:)] - [p2x(:) p2y(:) p2z(:)]) .* vcross;

t1 = sum(num,2);
d = (t1) ./ (vectorNorm3d(vcross) + eps);

d = reshape(abs(d),n1,n2);
