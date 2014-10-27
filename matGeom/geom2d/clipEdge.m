function edge2 = clipEdge(edge, box)
%CLIPEDGE Clip an edge with a rectangular box
%
%   EDGE2 = clipEdge(EDGE, BOX);
%   EDGE: [x1 y1 x2 y2],
%   BOX : [xmin xmax ymin ymax], or [xmin xmax ; ymin ymax].
%   return :
%   EDGE2 = [xc1 yc1 xc2 yc2];
%
%   If clipping is null, return [0 0 0 0];
%
%   if EDGE is a N-by-4 array, return an N-by-4 array, corresponding to each
%   clipped edge.
%
%   See also
%   edges2d, boxes2d, clipLine
%
% ---------
% author : David Legland 
% created the 14/05/2005.
% Copyright 2010 INRA - Cepia Software Platform.

%   HISTORY
%   2007-01-08 sort points according to position on edge, not to x coord
%       -> this allows to return edges with same orientation a source, and
%       to keep first or end points at the same position if their are not
%       clipped.
%   01/10/2010 fix bug due to precision, thanks to Reto Zingg.

% process data input
if size(box, 1) == 2
    box = box';
end

% get limits of window
xmin = box(1);
xmax = box(2);
ymin = box(3);
ymax = box(4);


% convert window limits into lines
lineX0 = [xmin ymin xmax-xmin 0];
lineX1 = [xmin ymax xmax-xmin 0];
lineY0 = [xmin ymin 0 ymax-ymin];
lineY1 = [xmax ymin 0 ymax-ymin];


% compute outcodes of each vertex
p11 = edge(:,1) < xmin; p21 = edge(:,3) < xmin;
p12 = edge(:,1) > xmax; p22 = edge(:,3) > xmax;
p13 = edge(:,2) < ymin; p23 = edge(:,4) < ymin;
p14 = edge(:,2) > ymax; p24 = edge(:,4) > ymax;
out1 = [p11 p12 p13 p14];
out2 = [p21 p22 p23 p24];

% detect edges totally inside window -> no clip.
inside = sum(out1 | out2, 2) == 0;

% detect edges totally outside window
outside = sum(out1 & out2, 2) > 0;

% select edges not totally outside, and process separately edges totally
% inside window
ind = find(~(inside | outside));

% allocate memroty for all clipped edges
edge2 = zeros(size(edge));

% copy result of edges totally inside clipping box
edge2(inside, :) = edge(inside, :);


for i = 1:length(ind)
    % current edge
    iedge = edge(ind(i), :);
        
    % compute intersection points with each line of bounding window
    px0 = intersectLineEdge(lineX0, iedge);
    px1 = intersectLineEdge(lineX1, iedge);
    py0 = intersectLineEdge(lineY0, iedge);
    py1 = intersectLineEdge(lineY1, iedge);
         
    % create array of points
    points  = [px0; px1; py0; py1; iedge(1:2); iedge(3:4)];
    
    % remove infinite points (edges parallel to box edges)
	points  = points(all(isfinite(points), 2), :);
    
    % sort points by x then y
    points = sortrows(points);
    
    % get center positions between consecutive points
    centers = (points(2:end,:) + points(1:end-1,:))/2;
    
    % find the centers (if any) inside window
    inside = find(  centers(:,1) >= xmin & centers(:,2) >= ymin & ...
                    centers(:,1) <= xmax & centers(:,2) <= ymax);

    % if multiple segments are inside box, which can happen due to finite
    % resolution, only take the longest segment
    if length(inside) > 1
        % compute delta vectors of the segments
        dv = points(inside+1,:) - points(inside,:); 
        % compute lengths of segments
        len = hypot(dv(:,1), dv(:,2));
        % find index of longest segment
        [a, I] = max(len); %#ok<ASGLU>
        inside = inside(I);
    end
    
    % if one of the center points is inside box, then the according edge
    % segment is indide box
    if length(inside) == 1
         % restore same direction of edge
        if iedge(1) > iedge(3) || (iedge(1) == iedge(3) && iedge(2) > iedge(4))
            edge2(ind(i), :) = [points(inside+1,:) points(inside,:)];
        else
            edge2(ind(i), :) = [points(inside,:) points(inside+1,:)];
        end
    end
    
end % end of loop over edges

