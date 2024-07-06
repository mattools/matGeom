function point = edgePoint(edge, pos)
%EDGEPOINT Extract a point from an edge.
%
%   POINT = edgePoint(EDGE, POS)
%   EDGE is a N*4 array containing N edges
%   POS is comprised between 0 (first point of edge) and 1 (last
%   point of the edge).
%
%   Example
%       edge = [10 10 20 10];
%       edgePoint(edge, 0)
%       [10 10]
%       edgePoint(edge, 0.5)
%       [15 15]
%       edgePoint(edge, 1)
%       [20 20]
%
%   See also 
%   edges2d distancePointEdge

% ------
% Author: Guilherme Froes Silva
% E-mail: g.froessilva@qut.edu.au
% Created: 2022-09-12, using MATLAB 9.12.0.1927505 (R2022a) Update 1
% Copyright 2022-2024

% number of points to compute
Np = size(pos,1);

% % number of vertices in polyline
Ne = size(edge, 1);

% allocate memory results
point = cell(Np, Ne);

% iterate on points
for i=1:Np
    for j = 1:Ne
        % compute index of edge (between 0 and 1)
        ind = floor(pos(i,j));

        % special case of last point of edge
        if ind==1            
            if size(edge,2)>4
                point{i,j} = edge(j,4:6);
            else
                point{i,j} = edge(j,3:4);
            end
            continue;
        elseif pos(i,j)==0
            if size(edge,2)>4
                point{i,j} = edge(j,1:3);
            else
                point{i,j} = edge(j,1:2);
            end
            continue;
        end

        % format index to ensure being on polyline
%         ind = min(max(ind, 0), 1);

        % position on current edge j
        t = pos(i,j);

        % parameters of current edge j
        x0 = edge(j, 1);
        y0 = edge(j, 2);
        dx = edge(j, 3) - x0;
        dy = edge(j, 4) - y0;
        if size(edge,2)>4
            z0 = edge(j, 5);
            dz = edge(j, 6) - z0;
        end
        % compute position of current point
        if size(edge,2)>4
            point{i, j} = [x0+t*dx, y0+t*dy, z0+t*dz];
        else
            point{i, j} = [x0+t*dx, y0+t*dy];
        end
    end
end
