function point = projPointOnLine3d(point, line)
%PROJPOINTONLINE3D Project a 3D point orthogonally onto a 3D line.
%
%   PT2 = projPointOnLine3d(PT, LINE).
%   Computes the (orthogonal) projection of 3D point PT onto the 3D line
%   LINE. 
%   
%   Function works also for multiple points and lines. In this case, it
%   returns multiple points.
%   Point PT1 is a N-by-3 array, and LINE is a N-by-6 array.
%   Result PT2 is a N-by-3 array, containing coordinates of orthogonal
%   projections of PT1 onto lines LINE. 
%
%
%   See also:
%   projPointOnLine, distancePointLine3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 2012-08-23.
%

%   HISTORY

% direction vector of the line
vx = line(:, 4);
vy = line(:, 5);
vz = line(:, 6);

% difference of point with line origin
dx = point(:,1) - line(:,1);
dy = point(:,2) - line(:,2);
dz = point(:,3) - line(:,3);

% Position of projection on line, using dot product
delta = vx .* vx + vy .* vy + vz .* vz;
tp = (dx .* vx + dy .* vy + dz .* vz) ./ delta;

% convert position on line to cartesian coordinates
point = [line(:,1) + tp .* vx, line(:,2) + tp .* vy, line(:,3) + tp .* vz];
