function theta = polygonNormalAngle(points, ind)
%POLYGONNORMALANGLE Compute the normal angle at a vertex of the polygon
%
%   THETA = polygonNormalAngle(POLYGON, IND);
%   where POLYGON is a set of points, and IND is index of a point in
%   polygon. The function compute the angle of the normal cone localized at
%   this vertex.
%   If IND is a vector of indices, normal angle is computed for each vertex
%   specified by IND.
%
%   Example
%   % creates a simple polygon
%   poly = [0 0;0 1;-1 1;0 -1;1 0];
%   % compute normal angle at each vertex
%   theta = polygonNormalAngle(poly, 1:size(poly, 1));
%   % sum of all normal angle of a non-intersecting polygon equals 2xpi
%   % (can be -2xpi if polygon is oriented clockwise)
%   sum(theta)
%
%   See also:
%   polygons2d, formatAngle
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
    
    theta(i) = angle3Points(p1, p0, p2) - pi;
end
