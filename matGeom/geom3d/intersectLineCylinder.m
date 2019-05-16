function points = intersectLineCylinder(line, cylinder, varargin)
%INTERSECTLINECYLINDER Compute intersection points between a line and a cylinder.
%
%   POINTS = intersectLineCylinder(LINE, CYLINDER)
%   Returns intersection points between a line and a cylinder.
%
%   Input parameters:
%   LINE     = [x0 y0 z0  dx dy dz]
%   CYLINDER = [x1 y1 z1 x2 y2 z2 R]
%
%   Output:
%   POINTS   = [x1 y1 z1 ; x2 y2 z2]
%
%   POINTS = intersectLineCylinder(LINE, CYLINDER, 'checkBounds', B)
%   Where B is a boolean (TRUE by default), check if the points are within
%   the bounds defined by the two extreme points. If B is false, the
%   cylinder is considered to be infinite.
%
%   Example
%     % Compute intersection between simple vertical cylinder and line
%     line = [60 60 60 1 2 3];
%     cylinder = [20 50 50 80 50 50 30];
%     points = intersectLineCylinder(line, cylinder);
%     % Display the different shapes
%     figure;
%     drawCylinder(cylinder);
%     hold on; light;
%     axis([0 100 0 100 0 100]);
%     drawLine3d(line);
%     drawPoint3d(points, 'ko');
%     
%
%     % Compute intersections when one of the points is outside the
%     % cylinder
%     line = [80 60 60 1 2 3];
%     cylinder = [20 50 50 80 50 50 30];
%     intersectLineCylinder(line, cylinder)
%     ans = 
%           67.8690   35.7380   23.6069
%
%   
%   See also
%   lines3d, intersectLinePlane, drawCylinder, cylinderSurfaceArea
%
%   References
%   See the link:
%   http://www.gamedev.net/community/forums/topic.asp?topic_id=467789
%

% ---
% Author: David Legland, from a file written by Daniel Trauth (RWTH)
% e-mail: david.legland@inra.fr
% Created: 2007-01-27

% HISTORY
% 2010-10-21 change cylinder argument convention, add bounds check and doc
% 2010-10-21 add check for points on cylinders, update doc


%% Parse input arguments

% default arguments
checkBounds = true;
% type of cylinder, one of {'closed', 'open', 'infinite'}
type = 'closed';

% parse inputs
while length(varargin)>1
    var = varargin{1};
    if strcmpi(var, 'checkbounds')
        checkBounds = varargin{2};
    elseif strcmpi(var, 'type')
        type = varargin{2};
    else
        error(['Unkown argument: ' var]);
    end
    varargin(1:2) = [];
end


%% Parse cylinder parameters

% Starting point of the line
l0 = line(1:3);

% Direction vector of the line
dl = line(4:6);

% position of cylinder extremities
c1 = cylinder(1:3);
c2 = cylinder(4:6);

% Direction vector of the cylinder
dc = c2 - c1;

% Radius of the cylinder
r = cylinder(7);


%% Resolution of a quadratic equation to find the increment

% normalisation coefficient corresponding to direction of vector
coef = dc / dot(dc, dc);

% Substitution of parameters
e = dl - dot(dl,dc) * coef;
f = (l0-c1) - dot(l0-c1, dc) * coef;

% Coefficients of 2-nd order equation
A = dot(e, e);
B = 2 * dot(e,f);
C = dot(f,f) - r^2;

% compute discriminant
delta = B^2 - 4*A*C;

% check existence of solution(s)
if delta < 0
    points = zeros(0, 3);
    return;
end

% extract roots
pos1 = (-B + sqrt(delta)) / (2*A);
pos2 = (-B - sqrt(delta)) / (2*A);
posList = [pos1;pos2];


%% Estimation of point positions

% process the smallest position
pos1 = min(posList);

% Point on the line: l0 + x*dl = p
point1 = l0 + pos1 * dl;

% process the greatest position
pos2 = max(posList);

% Point on the line: l0 + x*dl = p
point2 = l0 + pos2 * dl;

% Format result
points = [point1 ; point2];


%% Check if points are located between bounds

% if checkBounds option is not set, we can simply skip the rest
if ~checkBounds || strncmpi(type, 'infinite', 1)
    return;
end

% compute cylinder axis
axis = [c1 dc];

% compute position on axis
ts = linePosition3d(points, axis);

% check bounds for open cylinder
% (keep only intersection points whose projection is between the two
% cylinder extremities)
if strncmpi(type, 'open', 1)
    ind = ts>=0 & ts<=1;
    points = points(ind, :);
    return;
end

% which intersection fall before and after bounds
ind1 = find(ts < 0);
ind2 = find(ts > 1);

% case of both intersection on the same side -> no intersection
if length(ind1) == 2 || length(ind2) == 2
    points = zeros(0, 3);
    return;
end

% Process the remaining case of closed cylinder
% -> compute eventual intersection(s) with end faces
if ~isempty(ind1)
    plane = createPlane(c1, dc);
    points(ind1, :) = intersectLinePlane(line, plane);
end
if ~isempty(ind2)
    plane = createPlane(c2, dc);
    points(ind2, :) = intersectLinePlane(line, plane);
end


