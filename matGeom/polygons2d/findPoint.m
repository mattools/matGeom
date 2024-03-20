function index = findPoint(coord, points, varargin)
%FINDPOINT Find index of a point in an set from its coordinates.
% 
%   IND = findPoint(POINT, ARRAY) 
%   Returns the index of point whose coordinates match the 1-by-2 row array
%   POINT in the N-by-2 array ARRAY. If the point is not found, returns 0.
%   If several points are found, keep only the first one.
%
%   If POINT is a M-by-2 array, the result is a M-by-1 array, containing
%   the index in the array of each point given by COORD, or 0 if the point
%   is not found.
%
%   IND = findPoint(POINT, ARRAY, TOL) 
%   use specified tolerance, to find point within a distance of TOL.
%   Default tolerance is zero.
%
%   See also 
%    points2d, minDistancePoints, distancePoints, findClosestPoint

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-07-17
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

% number of points
np = size(coord, 1);

% allocate memory for result
index = zeros(np, 1);

% specify the tolerance
tol = 0;
if ~isempty(varargin)
    tol = varargin{1};
end

if tol == 0
    for i = 1:np
        % indices of matches
        ind = find(points(:,1) == coord(i,1) & points(:,2) == coord(i,2));
        
        % format current result
        if isempty(ind)
            index(i) = 0;
        else
            index(i) = ind(1);
        end
    end
else
    for i = 1:np
        % indices of matches
        ind = find(sqrt(sum(bsxfun(@minus, points, coord) .^ 2, 2)) <= tol);
        
        % format current result
        if isempty(ind)
            index(i) = 0;
        else
            index(i) = ind(1);
        end
    end
end
