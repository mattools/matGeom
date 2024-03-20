function edge = clipLine(line, box, varargin)
%CLIPLINE Clip a line with a box.
%
%   EDGE = clipLine(LINE, BOX);
%   LINE is a straight line given as a 4 element row vector: [x0 y0 dx dy],
%   with (x0 y0) being a point of the line and (dx dy) a direction vector,
%   BOX is the clipping box, given by its extreme coordinates: 
%   [xmin xmax ymin ymax].
%   The result is given as an edge, defined by the coordinates of its 2
%   extreme points: [x1 y1 x2 y2].
%   If line does not intersect the box, [NaN NaN NaN NaN] is returned.
%   
%   Function works also if LINE is a N-by-4 array, if BOX is a Nx4 array,
%   or if both LINE and BOX are N-by-4 arrays. In these cases, EDGE is a
%   N-by-4 array.
%   
%
%   Example
%   line = [30 40 10 0];
%   box = [0 100 0 100];
%   res = clipLine(line, box)
%   res = 
%       0 40 100 40
%
%   See also 
%   lines2d, boxes2d, edges2d
%   clipEdge, clipRay, clipLine3d
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2007-08-27, using Matlab 7.4.0.287 (R2007a)
% Copyright 2007-2023 INRA - Cepia Software Platform

% adjust size of two input arguments
nLines = size(line, 1);
nBoxes = size(box, 1);
if nLines == 1 && nBoxes > 1
    line = repmat(line, nBoxes, 1);
elseif nBoxes == 1 && nLines > 1
    box = repmat(box, nLines, 1);
elseif nLines ~= nBoxes
    error('bad sizes for input');
end

% allocate memory
nLines = size(line, 1);
edge   = zeros(nLines, 4);

% main loop on lines
for i = 1:nLines
    % extract limits of the box
    xmin = box(i, 1);
    xmax = box(i, 2);
    ymin = box(i, 3);
    ymax = box(i, 4);
    
    % use direction vector for box edges similar to direction vector of the
    % line in order to reduce computation errors
    delta = hypot(line(i,3), line(i,4));
    
	% compute intersection with each edge of the box
    px1 = intersectLines(line(i,:), [xmin ymin delta 0]);   % lower edge
    px2 = intersectLines(line(i,:), [xmax ymin 0 delta]);   % right edge
    py1 = intersectLines(line(i,:), [xmax ymax -delta 0]);  % upper edge
    py2 = intersectLines(line(i,:), [xmin ymax 0 -delta]);  % left edge
    
    % remove undefined intersections (case of lines parallel to box edges)
    points = [px1 ; px2 ; py1 ; py2];
    points = points(isfinite(points(:,1)), :);
	
    % sort points according to their position on the line
    pos = linePosition(points, line(i,:));
    [pos, inds] = sort(pos); %#ok<ASGLU>
    points = points(inds, :);
    
    % create clipped edge by using the two points in the middle
    ind = size(points, 1)/2;
    inter1 = points(ind,:);
    inter2 = points(ind+1,:);
    edge(i, 1:4) = [inter1 inter2];
    
    % check that middle point of the edge is contained in the box
    midX = mean(edge(i, [1 3]));
    xOk = xmin <= midX && midX <= xmax;
    midY = mean(edge(i, [2 4]));
    yOk = ymin <= midY && midY <= ymax;
    
    % if one of the bounding condition is not met, set edge to NaN
    if ~(xOk && yOk)
        edge (i,:) = NaN;
    end
end
