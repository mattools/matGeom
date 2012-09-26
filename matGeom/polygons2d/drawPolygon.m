function varargout = drawPolygon(varargin)
%DRAWPOLYGON Draw a polygon specified by a list of points
%
%   drawPolygon(POLY);
%   Packs coordinates in a single N-by-2 array.
%
%   drawPolygon(PX, PY);
%   Specifies coordinates in separate arrays.
%
%   drawPolygon(POLYS)
%   Packs coordinate of several polygons in a cell array. Each element of
%   the array is a Ni-by-2 double array.
%
%   drawPolygon(..., NAME, VALUE);
%   Specifies drawing options by using one or several parameter name-value
%   pairs, see the doc of plot function for details.
%
%   drawPolygon(AX, ...)
%   Specifies the axis to draw the polygon on.
%
%   H = drawPolygon(...);
%   Also return a handle to the list of line objects.
%
%   Example
%     % draw a red rectangle
%     poly = [10 10;40 10;40 30;10 30];
%     figure; drawPolygon(poly, 'r');
%     axis equal; axis([0 50 0 50]); 
%
%     % Draw two squares
%     px = [10 20 20 10 NaN 30 40 40 30]';
%     py = [10 10 20 20 NaN 10 10 20 20]';
%     figure; 
%     drawPolygon([px py], 'lineWidth', 2);
%     axis equal; axis([0 50 0 50]); 
% 
%   See also:
%   polygons2d, drawCurve
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 05/05/2004.
%

%   HISTORY
%   2008/10/15 manage polygons with holes
%   2011-10-11 add management of axes handle

% check input
if isempty(varargin)
    error('need to specify a polygon');
end

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

var = varargin{1};

%% Manage cell arrays of polygons

% case of a set of polygons stored in a cell array
if iscell(var)
    N = length(var);
    h = zeros(N, 1);
    for i = 1:N
        state = ishold(gca);
        hold on;
        % check for empty polygons
        if ~isempty(var{i})
            h(i) = drawPolygon(ax, var{i}, varargin{2:end});
        end
        if ~state
            hold off
        end
    end

    if nargout > 0
        varargout = {h};
    end

    return;
end


%% Parse coordinates and options

% Extract coordinates of polygon vertices
if size(var, 2) > 1
    % first argument is a polygon array
    px = var(:, 1);
    py = var(:, 2);
    varargin(1) = [];
else
    % arguments 1 and 2 correspond to x and y coordinate respectively
    if length(varargin) < 2
        error('Should specify either a N-by-2 array, or 2 N-by-1 vectors');
    end
    
    px = varargin{1};
    py = varargin{2};
    varargin(1:2) = [];
end    

% set default line format
if isempty(varargin)
    varargin = {'b-'};
end

% check case of polygons with holes
if any(isnan(px(:)))
    polygons = splitPolygons([px py]);
    h = drawPolygon(ax, polygons, varargin{:});

    if nargout > 0
        varargout = {h};
    end

    return;
end


%% Draw the polygon

% ensure last point is the same as the first one
px(size(px, 1)+1, :) = px(1,:);
py(size(py, 1)+1, :) = py(1,:);

% draw the polygon outline
h = plot(ax, px, py, varargin{:});

% format output arg
if nargout > 0
    varargout = {h};
end
