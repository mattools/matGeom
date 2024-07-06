function varargout = triangleGrid(bounds, origin, size, varargin)
%TRIANGLEGRID Generate triangular grid of points in the plane.
%
%   usage
%   PTS = triangleGrid(BOUNDS, ORIGIN, SIZE)
%   generate points, lying in the window defined by BOUNDS, given in form
%   [xmin ymin xmax ymax], starting from origin with a constant step equal
%   to size. 
%   SIZE is constant and is equals to the length of the sides of each
%   triangles. 
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-08-06
% Copyright 2005-2024 INRA - TPV URPOI - BIA IMASTE

dx = size(1);
dy = size(1)*sqrt(3);

% consider two square grids with different centers
pts1 = squareGrid(bounds, origin, [dx dy], varargin{:});
pts2 = squareGrid(bounds, origin + [dx dy]/2, [dx dy], varargin{:});

% gather points
pts = [pts1;pts2];


% process output
if nargout > 0
    varargout{1} = pts;
end
