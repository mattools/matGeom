function poly2 = clipPolygon3dHP(poly, plane)
%CLIPPOLYGON3DHP clip a 3D polygon with Half-space.
%
%   usage
%   POLY2 = clipPolygon3dHP(POLY, PLANE)
%   POLY is a [Nx3] array of points, and PLANE is given as :
%   [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2].
%   The result POLY2 is also an array of 3d points, sometimes smaller than
%   poly, and that can be [0x3] (empty polygon).
%
%   POLY2 = clipPolygon3dHP(POLY, PT0, NORMAL)
%   uses plane with normal NORMAL and containing point PT0.
%
%   TODO: not yet implemented
%
%   There is a problem for non-convex polygons, as they can be clipped in
%   several polygons. Possible solutions:
%   * create another function 'clipConvexPolygon3dPlane' or
%       'clipConvexPolygon3d', using a simplified algorithm
%   * returns a list of polygons instead of a single polygon,
%   * in the case of one polygon as return decide what to return
%   * and rename this function to 'clipPolygon3d'
%
%   See also:
%   poygons3d, polyhedra, clipConvexPolygon3dHP
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 02/08/2005.
%

%   HISTORY
%   2007-01-04 add todo flag
%   2011-08-17 rewrite algo, that works for convex polygons, but is slower
%       than function clipConvexPolgon3dHP


%% Pre-Processing

% ensure last point is the same as the first one (makes computation easier)
if sum(poly(end, :) == poly(1,:)) ~= 3
    poly = [poly; poly(1,:)];
end

% compute index of position wrt plane for each vertex
below = isBelowPlane(poly, plane);

% in the case of a polygon totally over the plane, return empty array
if sum(below) == 0
    poly2 = zeros(0, 3);
    return;
end

% in the case of a polygon totally over the plane, return original polygon
if sum(~below) == 0
    poly2 = poly;
    return;
end

% number of intersections
nInter = sum(abs(diff(below)));

% number of vertices of new polygon
N   = size(poly, 1);
% N2  = sum(below(1:end-1)) + nInter;
N2  = sum(below) + nInter;
poly2 = zeros(N2, 3);


%% Iteration on polygon vertices

% vertex index in current polygon
% initialized with first vertex below the plane (vertices before are drop)
i = find(below, 1, 'first');

% vertex index in result polygon
j = 1;

while i <= N
    
    if below(i)
        % keep points located below the plane
        poly2(j, :) = poly(i,:);
        i = i + 1;
        j = j + 1;

    else
        % current vertex is above the plane. We know that previous vertex
        % was below. We compute intersection of supporting line, find the
        % next vertex below, and find next intersection.
        
        % compute intersection of current edge with plane
        line = createLine3d(poly(i-1, :), poly(i, :));
        inter1 = intersectLinePlane(line, plane);
        poly2(j, :) = inter1;
        j = j + 1;
        
        % find index of next vertex below the plane, possibily re-starting
        % from the beginning of the polygon
        while ~below(mod(i - 1, N) + 1)
            i = i + 1;
        end
        
        % compute intersection of current line with plane
        i2 = mod(i - 1, N) + 1;
        line = createLine3d(poly(i2-1, :), poly(i2, :));
        inter2 = intersectLinePlane(line, plane);
        poly2(j, :) = inter2;
        j = j + 1;
        
        % add also the current vertex
        poly2(j, :) = poly(i2, :);
        j = j + 1;
        i = i + 1;
    end
end

% remove last point if it is the same as the first one
if sum(poly2(end, :) == poly2(1,:)) == 3
    poly2(end, :) = [];
end
