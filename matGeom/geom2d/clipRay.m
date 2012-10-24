function [edge isInside] = clipRay(ray, box)
% Clip a ray with a box
%
%   EDGE = clipRay(RAY, BOX);
%   RAY is a straight ray given as a 4 element row vector: [x0 y0 dx dy],
%   with (x0 y0) being the origin of the ray and (dx dy) its direction
%   vector, BOX is the clipping box, given by its extreme coordinates: 
%   [xmin xmax ymin ymax].
%   The result is given as an edge, defined by the coordinates of its 2
%   extreme points: [x1 y1 x2 y2].
%   If the ray does not intersect the box, [NaN NaN NaN NaN] is returned.
%   
%   Function works also if RAY is a Nx4 array, if BOX is a Nx4 array, or
%   if both RAY and BOX are Nx4 arrays. In these cases, EDGE is a Nx4
%   array.
%      
%   See also:
%   rays2d, boxes2d, edges2d, clipLine, drawRay
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-05-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2010 INRA - Cepia Software Platform.

%   HISTORY
%   2010-05-13 create from clipLine

% adjust size of two input arguments
if size(ray, 1)==1
    ray = repmat(ray, size(box, 1), 1);
elseif size(box, 1)==1
    box = repmat(box, size(ray, 1), 1);
elseif size(ray, 1) ~= size(box, 1)
    error('bad sizes for input');
end

% first compute clipping of supporting line
edge = clipLine(ray, box);

% detects valid edges (edges outside box are all NaN)
inds = find(isfinite(edge(:, 1)));

% compute position of edge extremities relative to the ray
n = length(inds);
pos1 = zeros(n, 1);
pos2 = zeros(n, 1);
for i = 1:n
    pos1(i) = linePosition(edge(inds(i),1:2), ray(inds(i),:));
    pos2(i) = linePosition(edge(inds(i),3:4), ray(inds(i),:));
end

% if first point is before ray origin, replace by origin
edge(inds(pos1<0), 1:2) = ray(inds(pos1<0), 1:2);

% if last point of edge is before origin, set all edge to NaN
edge(inds(pos2<0), :) = NaN;

% eventually returns result about inside or outside
if nargout > 1
    isInside = isfinite(edge(:,1));
end
