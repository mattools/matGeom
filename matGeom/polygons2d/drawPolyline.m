function varargout = drawPolyline(varargin)
%DRAWPOLYLINE Draw a polyline specified by a list of points
%
%   drawPolyline(COORD);
%   packs coordinates in a single [N*2] array.
%
%   drawPolyline(PX, PY);
%   specifies coordinates in separate arrays. PX and PY must be column
%   vectors with the same length.
%
%   drawPolyline(..., TYPE);
%   where TYPE is either 'closed' or 'open', specifies if last point must
%   be connected to the first one ('closed') or not ('open').
%   Default is 'open'.
%
%   drawPolyline(..., PARAM, VALUE);
%   specify plot options as described for plot command.
%
%   H = drawPolyline(...) also return a handle to the list of line objects.
%
%   Example:
%   % Draw a curve representing an ellipse
%   t = linspace(0, 2*pi, 100)';
%   px = 10*cos(t); py = 5*sin(t);
%   drawPolyline([px py], 'closed');
%   axis equal;
%
%   % The same, with different drawing options
%   drawPolyline([px py], 'closed', 'lineWidth', 2, 'lineStyle', '--');
%
%   See Also:
%   polygons2d, drawPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2004.
%

%   HISTORY
%   03/01/2007: better processing of input, and update doc (drawing
%       options and CLOSE option)
%   30/04/2009 rename as drawPolyline.
%   2011-10-11 add management of axes handle


% extract handle of axis to draw on
if ishandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% If first argument is a cell array, draw each curve individually,
% and eventually returns handle of each plot.
var = varargin{1};
if iscell(var)
    h = [];
    for i = 1:length(var(:))
        h = [h ; drawPolyline(ax, var{i}, varargin{2:end})];
    end
    if nargout > 0
        varargout = {h};
    end
    return;
end

% extract curve coordinate
if size(var, 2) == 1
    % first argument contains x coord, second argument contains y coord
    px = var;
    if length(varargin) == 1
        error('Wrong number of arguments in drawPolyline');
    end
    py = varargin{2};
    varargin = varargin(3:end);
else
    % first argument contains both coordinate
    px = var(:, 1);
    py = var(:, 2);
    varargin = varargin(2:end);
end

% check if curve is closed or open
closed = false;
if ~isempty(varargin)
    var = varargin{1};
    if strncmpi(var, 'close', 5)
        closed = true;
        varargin = varargin(2:end);
    elseif strncmpi(var, 'open', 4)
        closed = false;
        varargin = varargin(2:end);
    end
end

% if curve is closed, add first point at the end of the list
if closed
    px = [px; px(1)];
    py = [py; py(1)];
end

% plot the curve, with eventually optional parameters
h = plot(ax, px, py, varargin{:});

% format output arguments
if nargout > 0
    varargout = {h};
end
