function varargout = drawCurve(varargin)
%DRAWCURVE draw a curve specified by a list of points.
%
%   drawCurve(COORD);
%   packs coordinates in a single [N*2] array.
%
%   drawCurve(PX, PY);
%   specifies coordinates in separate arrays. PX and PY must be column
%   vectors with the same length.
%
%   drawCurve(..., TYPE);
%   where TYPE is either 'closed' or 'open', specifies if last point must
%   be connected to the first one ('closed') or not ('open').
%   Default is 'open'.
%
%   drawCurve(..., PARAM, VALUE);
%   specify plot options as described for plot command.
%
%   H = drawCurve(...) also return a handle to the list of line objects.
%
%   Example:
%   % Draw a curve representing an ellipse
%   t = linspace(0, 2*pi, 100)';
%   px = 10*cos(t); py = 5*sin(t);
%   drawCurve([px py], 'closed');
%   axis equal;
%
%   % The same, with different drawing options
%   drawCurve([px py], 'closed', 'lineWidth', 2, 'lineStyle', '--');
%
%   See Also:
%   polygons2d, drawPolyline

% ------
% Author: David Legland 
% e-mail: david.legland@inrae.fr
% Created: 2004-04-06
% Copyright 2004 INRA - TPV URPOI - BIA IMASTE

% deprecation warning
warning('geom2d:deprecated', ...
    '''drawCurve'' is deprecated, use ''drawPolyline'' instead');

% default values
closed = false;


% If first argument is a cell array, draw each curve individually,
% and eventually returns handle of each plot.
var = varargin{1};
if iscell(var)
    h = [];
    for i=1:length(var(:))
        h = [h ; drawCurve(var{i}, varargin{2:end})]; %#ok<AGROW>
    end
    if nargout>0
        varargout{1}=h;
    end
    return;
end

% extract curve coordinate
if size(var, 2)==1
    % first argument contains x coord, second argument contains y coord
    px = var;
    if length(varargin)==1
        error('Wrong number of arguments in drawCurve');
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

% add first point at the end to close the curve
if closed
    px = [px; px(1)];
    py = [py; py(1)];
end

% plot the curve, with eventually optional parameters
h = plot(px, py, varargin{:});

% format output arguments
if nargout>0
    varargout{1}=h;
end
