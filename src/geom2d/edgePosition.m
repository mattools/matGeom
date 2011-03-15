function d = edgePosition(point, edge)
%EDGEPOSITION Return position of a point on an edge
%
%   POS = edgePosition(POINT, EDGE);
%   Computes position of point POINT on the edge EDGE, relative to the
%   position of edge vertices.
%   EDGE has the form [x1 y1 x2 y2],
%   POINT has the form [x y], and is assumed to belong to edge.
%   The position POS has meaning:
%     POS<0:    POINT is located before the first vertex
%     POS=0:    POINT is located on the first vertex
%     0<POS<1:  POINT is located between the 2 vertices (on the edge)
%     POS=1:    POINT is located on the second vertex
%     POS<0:    POINT is located after the second vertex
%
%   POS = edgePosition(POINT, EDGES);
%   If EDGES is an array of NL edges, return NL positions, corresponding to
%   each edge.
%
%   POS = edgePosition(POINTS, EDGE);
%   If POINTS is an array of NP points, return NP positions, corresponding
%   to each point.
%
%   POS = edgePosition(POINTS, EDGES);
%   If POINTS is an array of NP points and edgeS is an array of NL edges,
%   return an array of [NP NL] position, corresponding to each couple
%   point-edge.
%
%   See also:
%   edges2d, createEdge, onEdge
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 25/05/2004.
%

%   HISTORY:
%   06/12/2009 created from linePosition

% number of points and of edges
Nl = size(edge, 1);
Np = size(point, 1);

if Np==Nl
    dxl = edge(:, 3)-edge(:,1);
    dyl = edge(:, 4)-edge(:,2);
    dxp = point(:, 1) - edge(:, 1);
    dyp = point(:, 2) - edge(:, 2);

    d = (dxp.*dxl + dyp.*dyl)./(dxl.*dxl+dyl.*dyl);

else
    % expand one of the array to have the same size
    dxl = repmat((edge(:,3)-edge(:,1))', Np, 1);
    dyl = repmat((edge(:,4)-edge(:,2))', Np, 1);
    dxp = repmat(point(:,1), 1, Nl) - repmat(edge(:,1)', Np, 1);
    dyp = repmat(point(:,2), 1, Nl) - repmat(edge(:,2)', Np, 1);

    d = (dxp.*dxl + dyp.*dyl)./(dxl.*dxl+dyl.*dyl);
end

