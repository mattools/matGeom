function varargout = hexagonalGrid(bounds, origin, size, varargin)
%HEXAGONALGRID Generate hexagonal grid of points in the plane.
%
%   usage
%   PTS = hexagonalGrid(BOUNDS, ORIGIN, SIZE)
%   generate points, lying in the window defined by BOUNDS (=[xmin ymin
%   xmax ymax]), starting from origin with a constant step equal to size.
%   SIZE is constant and is equals to the length of the sides of each
%   hexagon. 
%
%   TODO: add possibility to use rotated grid
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/08/2005.
%
size = size(1);
dx = 3*size;
dy = size*sqrt(3);



% consider two square grids with different centers
pts1 = squareGrid(bounds, origin + [0 0],        [dx dy], varargin{:});
pts2 = squareGrid(bounds, origin + [dx/3 0],     [dx dy], varargin{:});
pts3 = squareGrid(bounds, origin + [dx/2 dy/2],  [dx dy], varargin{:});
pts4 = squareGrid(bounds, origin + [-dx/6 dy/2], [dx dy], varargin{:});

% gather points
pts = [pts1;pts2;pts3;pts4];




% eventually compute also edges, clipped by bounds
% TODO : manage generation of edges 
if nargout>1
    edges = zeros([0 4]);
    x0 = origin(1);
    y0 = origin(2);

    % find all x coordinate
    x1 = bounds(1) + mod(x0-bounds(1), dx);
    x2 = bounds(3) - mod(bounds(3)-x0, dx);
    lx = (x1:dx:x2)';

    % horizontal edges : first find y's
    y1 = bounds(2) + mod(y0-bounds(2), dy);
    y2 = bounds(4) - mod(bounds(4)-y0, dy);
    ly = (y1:dy:y2)';
    
    % number of points in each coord, and total number of points
    ny = length(ly);
    nx = length(lx);
 
    if bounds(1)-x1+dx<size
        disp('intersect bounding box');
    end
    
    if bounds(3)-x2<size
        disp('intersect 2');
        edges = [edges;repmat(x2, [ny 1]) ly repmat(bounds(3), [ny 1]) ly];
        x2 = x2-dx;
        lx = (x1:dx:x2)';
        nx = length(lx);
    end
  
    for i=1:length(ly)
        ind = (1:nx)';
        tmpEdges(ind, 1) = lx;
        tmpEdges(ind, 2) = ly(i);
        tmpEdges(ind, 3) = lx+size;
        tmpEdges(ind, 4) = ly(i);
        edges = [edges; tmpEdges];
    end
    
end

% process output arguments
if nargout>0
    varargout{1} = pts;
    
    if nargout>1
        varargout{2} = edges;
    end
end