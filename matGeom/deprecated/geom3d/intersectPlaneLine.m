function point = intersectPlaneLine(plane, line)
%INTERSECTPLANELINE return intersection between a plane and a line
%
%   PT = intersectPlaneLine(PLANE, LINE) return the intersection point of
%   the given line and the given plane.
%   PLANE : [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   LINE :  [x0 y0 z0 dx dy dz]
%   PT :    [xi yi zi]
%   
%   Note: deprecated. Replaced by function 'intersectLinePlane'
%
%  Songbai Ji (6/23/2006). Bug fixed; also allow one plane, many lines; 
% many planes one line; or N planes and N lines configuration in the input.
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005.
%

%   HISTORY
%   24/11/2005 add support for multiple input
%   23/06/2006 correction from Songbai Ji
%   14/12/2006 correction for parallel lines and plane normals
%   05/01/2007 fixup for parallel lines and plane normals
%   17/10/2008 add warning for deprecation


warning('IMAEL:deprecatedFunction', ...
    'This function is deprecated, use ''intersectLinePlane'' instead');


% unify sizes of data
if size(plane, 1) == 1;     % one plane possible many lines
    plane = repmat(plane, size(line,1), 1);
elseif size(line,1) == 1;   % one line and many planes
    line = repmat(line, size(plane,1), 1);
elseif (size(plane,1) ~= size(line,1)) ; % N planes and M lines, not allowed for now.
    error('input size not correct, either one/many plane and many/one line, or same # of planes and lines!');
end

% initialize empty array
point = zeros(size(plane, 1), 3);

% plane normal
n = cross(plane(:,4:6), plane(:, 7:9), 2);

% get indices of line and plane which are parallel
par = abs(dot(n, line(:,4:6), 2))<1e-14;
point(par,:) = NaN;
% old version:
% II = find(abs(dot(n, line(:,4:6), 2))<1e-14);
% if ~isempty(II)
%     point(II,:) = [NaN NaN NaN];
% end

% difference between origins of plane and line
dp = plane(:,1:3) - line(:,1:3);

% relative position of intersection on line
% Should be Array multiply, original file had a bug. (songbai ji
% 6/23/2006).
% Divide only for non parallel vectors (DL, 
t = dot(n(~par,:), dp(~par,:), 2)./dot(n(~par,:), line(~par,4:6), 2);
%t = dot(n, dp, 2)./dot(n, line(:,4:6), 2);


% compute coord of intersection point
% point = line(:,1:3) + t*line(:,4:6);
% NOTE: original m file had a bug (in the above line).  It should be
% corrected as follows.  (Songbai Ji 6/23/2006).
%point = line(~par,1:3) + repmat(t,1,3).*line(~par,4:6);
%point = line(:,1:3) + repmat(t,1,3).*line(:,4:6);
point(~par, :) = line(~par,1:3) + repmat(t,1,3).*line(~par,4:6);

