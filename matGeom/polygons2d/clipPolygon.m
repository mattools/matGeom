function poly2 = clipPolygon(polygon, w)
%CLIPPOLYGON Clip a polygon with a rectangular box
%
%   POLY2 = clipPolygon(POLY, BOX);
%   POLY is [Nx2] array of points
%   BOX has the form: [XMIN XMAX YMIN YMAX].
%   Returns the polygon created by the itnersection of the polygon POLY and
%   the bounding box BOX.
%
%   Note: Works only for convex polygons at the moment.
%
%   See also:
%   polygons2d, boxes2d, clipPolygonHP
%

% ---------
% author : David Legland 
% created the 14/05/2005.
% Copyright 2010 INRA - Cepia Software Platform.

%   HISTORY
%   2007/09/14 fix doc

% check case of polygons stored in cell array
if iscell(polygon)
    poly2 = cell(1, length(polygon));
    for i=1:length(polygon)
        poly2{i} = clipPolygon(polygon{i}, w);
    end
    return;
end

% check case of empty polygon
N = size(polygon, 1);
if N==0
    poly2 = zeros(0, 2);
    return
end

% create edges array of polygon
edges = [polygon polygon([2:N 1], :)];

% clip edges
edges = clipEdge(edges, w);

% select non empty edges, and get their vertices
ind = sum(abs(edges), 2)>1e-14;
pts = unique([edges(ind, 1:2); edges(ind, 3:4)], 'rows');

% add vertices of window corner
corners = [w(1) w(3); w(1) w(4);w(2) w(3);w(2) w(4)];
ind = inpolygon(corners(:,1), corners(:,2), polygon(:,1), polygon(:,2));
pts = [pts; corners(ind, :)];

% polygon totally outside the window
if size(pts, 1)==0
    poly2 = pts;
    return;
end

% compute centroid of visible polygon
pc = centroid(pts);

% sort vertices around polygon
angle = edgeAngle([repmat(pc, [size(pts, 1) 1]) pts]);
[dummy, I] = sort(angle); %#ok<ASGLU>

% create resulting polygon
poly2 = pts(I, :);
