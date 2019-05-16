function d = isPlane(plane)
%ISPLANE Check if input is a plane.
%
%   B = isPlane(PLANE) where PLANE should be a plane or multiple planes
%
%   Example
%     isPlane([...
%         0 0 0 1 0 0 0 1 0;...
%         0 0 0 1 0 0 -1 0 0;...
%         0 0 0 1i 0 0 -1 0 0;...
%         0 0 0 nan 0 0 0 1 0;...
%         0 0 0 inf 0 0 0 1 0])
%
%   See also
%   createPlane3d
%
% ------
% Author: oqilipo, David Legland
% Created: 2017-07-09
% Copyright 2017

narginchk(1,1)

if size(plane,2)~=9
    d=false(size(plane,1),1);
    return
end

a = ~any(isnan(plane),2);
b = ~any(isinf(plane),2);
c = ~isParallel3d(plane(:,4:6), plane(:,7:9));

d=a & b & c;