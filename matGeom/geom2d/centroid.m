function center = centroid(varargin)
%CENTROID Compute centroid (center of mass) of a set of points
%
%   PTS = centroid(POINTS)
%   PTS = centroid(PTX, PTY)
%   Computes the ND-dimensional centroid of a set of points. 
%   POINTS is an array with as many rows as the number of points, and as
%   many columns as the number of dimensions. 
%   PTX and PTY are two column vectors containing coordinates of the
%   2-dimensional points.
%   The result PTS is a row vector with Nd columns.
%
%   PTS = centroid(POINTS, MASS)
%   PTS = centroid(PTX, PTY, MASS)
%   Computes center of mass of POINTS, weighted by coefficient MASS.
%   POINTS is a Np-by-Nd array, MASS is Np-by-1 array, and PTX and PTY are
%   also both Np-by-1 arrays.
%
%   Example:
%   pts = [2 2;6 1;6 5;2 4];
%   centroid(pts)
%   ans =
%        4     3
%
%   See Also:
%   points2d, polygonCentroid
%   
% ---------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% created the 07/04/2003.
% Copyright 2010 INRA - Cepia Software Platform.
%

%   HISTORY
%   2009-06-22 support for 3D points
%   2010-04-12 fix bug in weighted centroid
%   2010-12-06 update doc


%% extract input arguments

% use empty mass by default
mass = [];

if nargin==1
    % give only array of points
    pts = varargin{1};
    
elseif nargin==2
    % either POINTS+MASS or PX+PY
    var = varargin{1};
    if size(var, 2)>1
        % arguments are POINTS, and MASS
        pts = var;
        mass = varargin{2};
    else
        % arguments are PX and PY
        pts = [var varargin{2}];
    end
    
elseif nargin==3
    % arguments are PX, PY, and MASS
    pts = [varargin{1} varargin{2}];
    mass = varargin{3};
end

%% compute centroid

if isempty(mass)
    % no weight
    center = mean(pts);
    
else
    % format mass to have sum equal to 1, and column format
    mass = mass(:)/sum(mass(:));
    
    % compute weighted centroid
    center = sum(bsxfun(@times, pts, mass), 1);
    % equivalent to:
    % center = sum(pts .* mass(:, ones(1, size(pts, 2))));
end
