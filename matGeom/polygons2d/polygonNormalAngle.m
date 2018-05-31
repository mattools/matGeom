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
%   polygons2d, polygonOuterNormal, normalizeAngle
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2005-11-30
% Copyright 2005 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas).


% number of points
np = size(points, 1);

% number of angles to compute
nv = length(ind);

theta = zeros(nv, 1);

for i = 1:nv
    % current vertex
    curr = points(ind(i), :);
    
    % previous and next vertices
    prev = points(mod(ind(i)-2, np)+1, :);
    next = points(mod(ind(i), np)+1, :);
    
    theta(i) = angle3Points(prev, curr, next) - pi;
end
