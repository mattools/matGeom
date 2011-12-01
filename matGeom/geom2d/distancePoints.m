function dist = distancePoints(p1, p2, varargin)
%DISTANCEPOINTS Compute distance between two points
%
%   D = distancePoints(P1, P2)
%   Return the Euclidean distance between points P1 and P2.
%
%   If P1 and P2 are two arrays of points, result is a N1*N2 array
%   containing distance between each point of P1 and each point of P2. 
%
%   D = distancePoints(P1, P2, NORM)
%   Compute distance using the specified norm. NORM=2 corresponds to usual
%   euclidean distance, NORM=1 corresponds to Manhattan distance, NORM=inf
%   is assumed to correspond to maximum difference in coordinate. Other
%   values (>0) can be specified.
%
%   D = distancePoints(..., 'diag')
%   compute only distances between P1(i,:) and P2(i,:).
%
%   See also:
%   points2d, minDistancePoints, nndist
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 24/02/2004.
%

%   HISTORY :
%   25/05/2004: manage 2 array of points
%   07/04/2004: add option for computing only diagonal.
%   30/10/2006: generalize to any dimension, and manage different norms
%   03/01/2007: bug for arbitrary norm, and update doc
%   28/08/2007: fix bug for norms 2 and infinite, in diagonal case


%% Setup options

% default values
diag = false;
norm = 2;

% check first argument: norm or diag
if ~isempty(varargin)
    var = varargin{1};
    if isnumeric(var)
        norm = var;
    elseif strncmp('diag', var, 4)
        diag = true;
    end
    varargin(1) = [];
end

% check last argument: diag
if ~isempty(varargin)
    var = varargin{1};
    if strncmp('diag', var, 4)
        diag = true;
    end
end


% number of points in each array and their dimension
n1  = size(p1, 1);
n2  = size(p2, 1);
d   = size(p1, 2);

if diag
    % compute distance only for apparied couples of pixels
    dist = zeros(n1, 1);
    if norm==2
        % Compute euclidian distance. this is the default case
        % Compute difference of coordinate for each pair of point
        % and for each dimension. -> dist is a [n1*n2] array.
        for i=1:d
            dist = dist + (p2(:,i)-p1(:,i)).^2;
        end
        dist = sqrt(dist);
    elseif norm==inf
        % infinite norm corresponds to maximal difference of coordinate
        for i=1:d
            dist = max(dist, abs(p2(:,i)-p1(:,i)));
        end
    else
        % compute distance using the specified norm.
        for i=1:d
            dist = dist + power((abs(p2(:,i)-p1(:,i))), norm);
        end
        dist = power(dist, 1/norm);
    end
else
    % compute distance for all couples of pixels
    dist = zeros(n1, n2);
    if norm==2
        % Compute euclidian distance. this is the default case
        % Compute difference of coordinate for each pair of point
        % and for each dimension. -> dist is a [n1*n2] array.
        for i=1:d
            % equivalent to:
            % dist = dist + ...
            %   (repmat(p1(:,i), [1 n2])-repmat(p2(:,i)', [n1 1])).^2;
            dist = dist + (p1(:, i*ones(1, n2))-p2(:, i*ones(n1, 1))').^2;
        end
        dist = sqrt(dist);
    elseif norm==inf
        % infinite norm corresponds to maximal difference of coordinate
        for i=1:d
            dist = max(dist, abs(p1(:, i*ones(1, n2))-p2(:, i*ones(n1, 1))'));
        end
    else
        % compute distance using the specified norm.
        for i=1:d
            % equivalent to:
            % dist = dist + power((abs(repmat(p1(:,i), [1 n2]) - ...
            %     repmat(p2(:,i)', [n1 1]))), norm);
            dist = dist + power((abs(p1(:, i*ones(1, n2))-p2(:, i*ones(n1, 1))')), norm);
        end
        dist = power(dist, 1/norm);
    end
end

