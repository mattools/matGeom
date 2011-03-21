function [nodes, edges] = medialAxisConvex(points)
%MEDIALAXISCONVEX Compute medial axis of a convex polygon
%
%   [N, E] = medialAxisConvex(POLYGON);
%   where POLYGON is given as a set of points [x1 y1;x2 y2 ...], returns
%   the medial axis of the polygon as a graph.
%   N is a set of nodes. The first elements of N are the vertices of the
%   original polygon.
%   E is a set of edges, containing indices of source and target nodes.
%   Edges are sorted according to order of creation. Index of first vertex
%   is lower than index of last vertex, i.e. edges always point to newly
%   created nodes.
%
%   Notes:
%   - Is not fully implemented, need more development (usually crashes for
%       polygons with more than 6-7 points...)
%   - Works only for convex polygons.
%   - Complexity is not optimal: this algorithm is O(n*log n), but linear
%   algorithms exist.
%
%   See also:
%   polygons2d, bisector
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/07/2005.
%

%   HISTORY
%   18/04/2007: fix some typos, note the function to be unimplemented

%   TODO: is not fully implemented, need to finish it

% eventually remove the last point if it is the same as the first one
if points(1,:) == points(end, :)
    nodes = points(1:end-1, :);
else
    nodes = points;
end

% special case of triangles: 
% compute directly the gravity center, and simplify computation.
if size(nodes, 1)==3
    nodes = [nodes; mean(nodes, 1)];
    edges = [1 4;2 4;3 4];
    return
end

% number of nodes, and also of initial rays
N = size(nodes, 1);

% create ray of each vertex
rays = zeros(N, 4);
rays(1, 1:4) = bisector(nodes([2 1 N], :));
rays(N, 1:4) = bisector(nodes([1 N N-1], :));
for i=2:N-1
    rays(i, 1:4) = bisector(nodes([i+1, i, i-1], :));
end

% add indices of edges producing rays (indices of first vertex, second
% vertex is obtained by adding one modulo N).
rayEdges = [[N (1:N-1)]' (1:N)'];

pint = intersectLines(rays, rays([2:N 1], :));
%ti   = linePosition(pint, rays);
%ti   = min(linePosition(pint, rays), linePosition(pint, rays([2:N 1], :)));
ti = distancePointLine(pint, ...
    createLine(points([N (1:N-1)]', :), points((1:N)', :)));

% create list of events.
% terms are : R1 R2 X Y t0
% R1 and R2 are indices of involved rays
% X and Y is coordinate of intersection point
% t0 is position of point on rays
events = sortrows([ (1:N)' [2:N 1]' pint ti], 5);

% initialize edges
edges = zeros(0, 2);


% -------------------
% process each event until there is no more

% start after index of last vertex, and process N-3 intermediate rays
for i=N+1:2*N-3
    % add new node at the rays intersection
    nodes(i,:) = events(1, 3:4);
    
    % add new couple of edges
    edges = [edges; events(1,1) i; events(1,2) i];
            
    % find the two edges creating the new emanating ray
    n1 = rayEdges(events(1, 1), 1);
    n2 = rayEdges(events(1, 2), 2);    
    
    % create the new ray
    line1 = createLine(nodes(n1, :), nodes(mod(n1,N)+1, :));
    line2 = createLine(nodes(mod(n2,N)+1, :), nodes(n2, :));
    ray0 = bisector(line1, line2);
    
    % set its origin to emanating point
    ray0(1:2) = nodes(i, :);

    % add the new ray to the list
    rays = [rays; ray0];
    rayEdges(size(rayEdges, 1)+1, 1:2) = [n1 n2];
    
    % find the two neighbour rays
    ind = sum(ismember(events(:,1:2), events(1, 1:2)), 2)==0;
    ir = unique(events(ind, 1:2));
    ir = ir(~ismember(ir, events(1,1:2)));
    
    % create new intersections
    pint = intersectLines(ray0, rays(ir, :));
    %ti   = min(linePosition(pint, ray0), linePosition(pint, rays(ir, :))) + events(1,5);
    ti = distancePointLine(pint, line1);
    
    % remove all events involving old intersected rays
    ind = sum(ismember(events(:,1:2), events(1, 1:2)), 2)==0;
    events = events(ind, :);
    
    % add the newly formed events
    events = [events; ir(1) i pint(1,:) ti(1); ir(2) i pint(2,:) ti(2)];

    % and sort them according to 'position' parameter
    events = sortrows(events, 5);
end

% centroid computation for last 3 rays
nodes = [nodes; mean(events(:, 3:4))];
edges = [edges; [unique(events(:,1:2)) ones(3, 1)*(2*N-2)]];
