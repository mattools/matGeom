function varargout = squareGrid(bounds, origin, size)
%SQUAREGRID Generate equally spaces points in plane.
%
%   usage
%   PTS = squareGrid(BOUNDS, ORIGIN, SIZE)
%   generate points, lying in the window defined by BOUNDS (=[xmin ymin
%   xmax ymax]), starting from origin with a constant step equal to size.
%   
%   Example
%   PTS = squareGrid([0 0 10 10], [3 3], [4 2])
%   will return points : 
%   [3 1;7 1;3 3;7 3;3 5;7 5;3 7;7 7;3 9;7 9];
%
%
%
%   TODO: add possibility to use rotated grid
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/08/2005.
%

% find all x coordinate
x1 = bounds(1) + mod(origin(1)-bounds(1), size(1));
x2 = bounds(3) - mod(bounds(3)-origin(1), size(1));
lx = (x1:size(1):x2)';

% find all y coordinate
y1 = bounds(2) + mod(origin(2)-bounds(2), size(2));
y2 = bounds(4) - mod(bounds(4)-origin(2), size(2));
ly = (y1:size(2):y2)';

% number of points in each coord, and total number of points
ny = length(ly);
nx = length(lx);
np = nx*ny;

% create points
pts = zeros(np, 2);
for i=1:ny
    pts( (1:nx)'+(i-1)*nx, 1) = lx;
    pts( (1:nx)'+(i-1)*nx, 2) = ly(i);
end    

% process output
if nargout>0
    varargout{1} = pts;
end
