function varargout = drawPolygon (px, varargin)
%DRAWPOLYGON Draw a polygon specified by a list of points.
%
%   drawPolygon(POLY);
%   Packs coordinates in a single N-by-2 array, with N the vertex number.
%
%   drawPolygon(PX, PY);
%   Specifies coordinates in separate arrays. Both array must be N-by-1,
%   with N the number of vertices.
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
%   See also 
%   polygons2d, drawPolyline

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2004-05-05
% Copyright 2004-2022 INRA - TPV URPOI - BIA IMASTE

% Store hold state
state = ishold(gca);
hold on;


%% Check input
if nargin < 1
    error ('should specify at least one argument');
end

% check for empty polygons
if isempty (px)
    return
end

% extract handle of axis to draw on
ax = gca;
if isAxisHandle(px)
    ax          = px;
    px          = varargin{1};
    varargin(1) = [];
end


%% Manage cell arrays of polygons

% case of a set of polygons stored in a cell array
if iscell(px)
    h   = cellfun(@(x) drawPolygon(ax, x, varargin{:}), px, 'UniformOutput', 0);
    h   = horzcat(h{:});
    
else
    % Check size vs number of arguments
    if size(px, 2) == 2
        % Case of polygon specified as a N-by-2 array (most standard case)
        py = px(:, 2);
        px = px(:, 1);
        
    elseif size(px, 2) == 1
        % Case of polygon specified as two N-by-1 arrays with same length
        if nargin < 2 || nargin == 2 && ~isnumeric(varargin{1})
            error('Matgeom:invalid_input_arg', ...
                'Should specify either a N-by-2 array, or 2 N-by-1 vectors');
        end
        
        % Extract coordinates of polygon vertices
        py          = varargin{1};
        varargin(1) = [];
        
        if length(py) ~= length(px)
            error('Matgeom:invalid_input_arg', ...
                'X and Y coordinate arrays should have same lengths (%d,%d)', ...
                length(px), length(py)) 
        end
        
    else
        error('Matgeom:invalid_input_arg', 'Should specify a N-by-2 array');
    end
    
    % set default line format
    if isempty (varargin)
        varargin = {'b-'};
    end
   
    % Check case of polygons with holes
    if any (isnan (px(:)) )
        polygons = splitPolygons ([px py]);
        h        = drawPolygon (ax, polygons, varargin{:});
        
    else
        % ensure last point is the same as the first one
        px(end+1, :) = px(1,:);
        py(end+1, :) = py(1,:);

        % draw the polygon outline
        h = plot(ax, px, py, varargin{:});
        
    end % whether there where holes
    
end % whether input arg was a cell

if ~state
    hold off
end

% avoid returning argument if not required
if nargout > 0
    varargout = {h};
end
