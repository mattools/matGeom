function varargout = drawGrid3d(varargin)
%DRAWGRID3D Draw a 3D grid on the current axis.
%
%   drawGrid3d
%   draws a 3D square grid, with origin (0,0,0) and spacing 1 in each
%   direction, with bounds corresponding to the bounds of current axis.
%
%   drawGrid3d(SPACING)
%   where spacing is either a scalar or a [1x3] matrix, specifies the size
%   of the unit cell.
%
%   drawGrid3d(ORIGIN, SPACING)
%   Also specify origin of grid. ORIGIN is a [1x3] array.
%
%   drawGrid3d(..., EDGE)
%   specifies whether function should draw edges touching edges of axis.
%   EDGE is a characheter string, which can be :
%   - 'OPEN' : each line start from one face of window to the opposite
%   face. This results in a 'spiky' grid.
%   - 'CLOSED' (default value) : each line stops at the last visible point
%   of the grid for this line. The result looks like a box (no free spikes
%   around the grid).
%
%   H = drawGrid3d(...);
%   return a vector of handles for each LINE object which was crated.
%
%
%   Example
%     figure; hold on; axis equal; axis([-5 65 -5 45 -5 45]); view(3);
%     drawGrid3d([0 0 0], [20 20 20]);
%
%
%   See also 
%     drawLine3d, drawEdge3d, clipLine3d

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2005-11-17
% Copyright 2005-2023 INRA - CEPIA Nantes - MIAJ (Jouy-en-Josas)

%% initialize variables

% extract handle of axis to draw on
[hAx, varargin] = parseAxisHandle(varargin{:});

% default values
closed = true;
origin = [0 0 0];
spacing = [1 1 1];

% check if grid is open or not
str = '';
if ~isempty(varargin)
    str = varargin{end};
end
if ischar(str)
    if strncmpi(str, 'open', 4)
        closed = false;
    end
    varargin = varargin(1:end-1);
end

% check origin and grid spacing
if length(varargin)==1
    spacing = varargin{1};
elseif length(varargin)==2
    origin = varargin{1};
    spacing = varargin{2};
end

%% Compute internal data

% get axis limits
ax = axis(hAx);
x0 = ax(1); x1 = ax(2);
y0 = ax(3); y1 = ax(4);
z0 = ax(5); z1 = ax(6);

% get first and last coordinates of the grid in each direction
dx = spacing(1); dy = spacing(2); dz = spacing(3);
xe = x0 + mod(origin(1) - x0, dx);
xf = x1 - mod(x1 - origin(1), dx);
ye = y0 + mod(origin(2) - y0, dy);
yf = y1 - mod(y1 - origin(2), dy);
ze = z0 + mod(origin(1) - z0, dz);
zf = z1 - mod(z1 - origin(1), dz);

% update first and last coordinate if grid is 'closed'
if closed
    x0 = xe; x1 = xf;
    y0 = ye; y1 = yf;
    z0 = ze; z1 = zf;
end


%% Draw the grid

% header array, one header for each line segment
h = [];

% draw lines parallel to x axis
for y = ye:dy:yf
    for z = ze:dz:zf
        h = [h; drawEdge3d(hAx, [x0 y z x1 y z])]; %#ok<AGROW>
    end
end

% draw lines parallel to y axis
for x = xe:dx:xf
    for z = ze:dz:zf
        h = [h; drawEdge3d(hAx, [x y0 z x y1 z])]; %#ok<AGROW>
    end
end

% draw lines parallel to z axis
for x = xe:dx:xf
    for y = ye:dy:yf
        h = [h; drawEdge3d(hAx, [x y z0 x y z1])]; %#ok<AGROW>
    end
end


%% Check output arguments

if nargout > 0
    varargout{1} = h;
end
