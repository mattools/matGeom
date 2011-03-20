function dist = distancePoints3d(p1, p2, varargin)
%DISTANCEPOINTS3D Compute euclidean distance between pairs of 3D Points
%
%   D = distancePoints3d(P1, P2) return distance between points P1 and
%   P2, given as [X Y Z].
%   
%   If P1 and P2 are two arrays of points, result is a N1*N2 array
%   containing distance between each point of P1 and each point of P2. 
%
%
%   D = distancePoints3d(P1, P2, NOR)
%   with NOR being 1, 2, or Inf, corresponfing to the norm used. Default is
%   2 (euclidean norm). 1 correspond to manhattan (or taxi driver) distance
%   and Inf to maximum difference in each coordinate.
%
%
%   See also:
%   points3d, minDistancePoints, distancePoints
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   21/02/2005: add different norms
%   28/08/2007: deprecate

norm = 2;
if length(varargin)==1
    norm = varargin{1};
end

% number of points of each array
n1 = size(p1, 1);
n2 = size(p2, 1);

% compute difference of coordinate for each pair of point ([n1*n2] array)
dx = repmat(p1(:,1), [1 n2]) - repmat(p2(:,1)', [n1 1]);
dy = repmat(p1(:,2), [1 n2]) - repmat(p2(:,2)', [n1 1]);
dz = repmat(p1(:,3), [1 n2]) - repmat(p2(:,3)', [n1 1]);

switch(norm)
    case 1
        dist = abs(dx) + abs(dy) + abs(dz);
    case 2
        dist = sqrt(dx.*dx + dy.*dy + dz.*dz);
    case Inf
        dist = max([abs(dx) abs(dy) abs(dz)], [], 2);
    otherwise
        dist = power(power(dx, norm) + power(dy, norm) + power(dz, norm), 1/norm);
end
