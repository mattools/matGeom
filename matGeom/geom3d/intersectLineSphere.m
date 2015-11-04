function points = intersectLineSphere(line, sphere, varargin)
%INTERSECTLINESPHERE Return intersection points between a line and a sphere
%
%   PTS = intersectLineSphere(LINE, SPHERE);
%   Returns the two points which are the intersection of the given line and
%   sphere. 
%   LINE   : [x0 y0 z0  dx dy dz]
%   SPHERE : [xc yc zc  R]
%   PTS     : [x1 y1 z1 ; x2 y2 z2]
%   If there is no intersection between the line and the sphere, return a
%   2-by-3 array containing only NaN.
%
%   Example
%     % draw the intersection between a sphere and a collection of parallel
%     % lines 
%     sphere = [50.12 50.23 50.34 40];
%     [x, y] = meshgrid(10:10:90, 10:10:90);
%     n = numel(x);
%     lines = [x(:) y(:) zeros(n,1) zeros(n,2) ones(n,1)];
%     figure; hold on; axis equal;
%     axis([0 100 0 100 0 100]); view(3);
%     drawSphere(sphere);
%     drawLine3d(lines);
%     pts = intersectLineSphere(lines, sphere);
%     drawPoint3d(pts, 'ro');
%
%   See also
%   spheres, circles3d, intersectPlaneSphere
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   2011-06-21 bug for tangent lines, add tolerance


%% Process input arguments

% check if user-defined tolerance is given
tol = 1e-14;
if ~isempty(varargin)
    tol = varargin{1};
end

% difference between centers
dc = bsxfun(@minus, line(:, 1:3), sphere(:, 1:3));

% equation coefficients
a = sum(line(:, 4:6) .* line(:, 4:6), 2);
b = 2 * sum(bsxfun(@times, dc, line(:, 4:6)), 2);
c = sum(dc.*dc, 2) - sphere(:,4).*sphere(:,4);

% solve equation
delta = b.*b - 4*a.*c;

% initialize empty results
points = NaN * ones(2 * size(delta, 1), 3);


%% process couples with two intersection points

% proces couples with two intersection points
inds = find(delta > tol);
if ~isempty(inds)
    % delta positive: find two roots of second order equation
    u1 = (-b(inds) -sqrt(delta(inds))) / 2 ./ a(inds);
    u2 = (-b(inds) +sqrt(delta(inds))) / 2 ./ a(inds);
    
    % convert into 3D coordinate
    points(inds, :) = line(inds, 1:3) + bsxfun(@times, u1, line(inds, 4:6));
    points(inds+length(delta),:) = line(inds, 1:3) + bsxfun(@times, u2, line(inds, 4:6));
end


%% process couples with one intersection point

% proces couples with two intersection points
inds = find(abs(delta) < tol);
if ~isempty(inds)
    % delta around zero: find unique root, and convert to 3D coord.
    u = -b(inds) / 2 ./ a(inds);
    
    % convert into 3D coordinate
    pts = line(inds, 1:3) + bsxfun(@times, u, line(inds, 4:6));
    points(inds, :) = pts;
    points(inds+length(delta),:) = pts;
end
