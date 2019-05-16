function theta = polygon3dNormalAngle(points, ind)
%POLYGON3DNORMALANGLE Normal angle at a vertex of the 3D polygon.
%
%   THETA = polygon3DNormalAngle(POLYGON, IND)
%   where POLYGON is a set of points, and IND is index of a point in
%   polygon. The function compute the angle of the normal cone localized at
%   this vertex.
%   If IND is a vector of indices, normal angle is computed for each vertex
%   specified by IND.
%
%   Example
%   % create an equilateral triangle in space
%   poly3d = [1 1 0;-1 0 1;0 -1 -1];
%   % compute each normal angle
%   theta = polygon3dNormalAngle(poly3d, 1:size(poly3d, 1));
%   % sum of normal angles must be equal to 2*PI for simple polygons
%   sum(theta)
%
%   IMPORTANT NOTE: works only for convex angles ! ! ! !
%
%   See also
%   polygons3d, faceNormalAngle
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2005-11-30
% Copyright 2005 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


% number of points
np = size(points, 1);

% number of angles to compute
nv = length(ind);

theta = zeros(nv, 1);

for i=1:nv
    p0 = points(ind(i), :);
    
    if ind(i)==1
        p1 = points(np, :);
    else
        p1 = points(ind(i)-1, :);
    end
    
    if ind(i)==np
        p2 = points(1, :);
    else
        p2 = points(ind(i)+1, :);
    end
    
    theta(i) = pi - anglePoints3d(p1, p0, p2);
end
