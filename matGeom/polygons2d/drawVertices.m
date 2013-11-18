function varargout = drawVertices(varargin)
%DRAWVERTICES Draw the vertices of a polygon or polyline
%
%   drawVertices(POLY)
%   Draws the vertices of the given polygon, using pre-defined style.
%   Default is to draw vertices as squares, with the first vertex filled. 
%
%   Example
%     poly = circleToPolygon([20 30 40], 16);
%     drawPolygon(poly); 
%     hold on; axis equal;
%     drawVertices(poly);
%
%   See also
%   drawPoint, drawPolygon, drawPolyline
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-11,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

var = varargin{1};


%% Manage cell arrays of polygons / polylines

% case of a set of polygons stored in a cell array
if iscell(var)
    N = length(var);
    h = zeros(N, 1);
    for i = 1:N
        state = ishold(gca);
        hold on;
        % check for empty polygons
        if ~isempty(var{i})
            h(i) = drawVertices(ax, var{i}, varargin{2:end});
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

% Extract coordinates of vertices
if size(var, 2) > 1
    % first argument is a vertex array
    px = var(:, 1);
    py = var(:, 2);
    varargin(1) = [];
    
elseif length(varargin) >= 2 && isnumeric(varargin{1}) && isnumeric(varargin{2})
    % arguments 1 and 2 correspond to x and y coordinate respectively    
    px = varargin{1};
    py = varargin{2};
    varargin(1:2) = [];
    
else
    % unknow input format
    error('Should specify either a N-by-2 array, or 2 N-by-1 vectors');
end

% concatenate input argument(s) with default options
defaults = {'MarkerSize', 6};
if length(varargin) == 1
    varargin = [varargin defaults];
else
    varargin = [{'ks'} defaults varargin];
end


%% Draw the vertices

% draw the vertices
h = plot(ax, px, py, varargin{:});

% draw the first vertex with a different style
plot(ax, px(1), py(1), 'ks', 'MarkerFaceColor', 'k', 'MarkerSize', 8);

% format output arg
if nargout > 0
    varargout = {h};
end
