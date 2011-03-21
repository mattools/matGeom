function varargout = drawPolygon(varargin)
%DRAWPOLYGON Draw a polygon specified by a list of points
%
%   drawPolygon(COORD);
%   Packs coordinates in a single [N*2] array.
%
%   drawPolygon(PX, PY);
%   Specifies coordinates in separate arrays.
%
%   drawPolygon(POLYS)
%   Packs coordinate of several polygons in a cell array. Each element of
%   the array is a Ni*2 double array.
%
%   H = drawPolygon(...);
%   Also return a handle to the list of line objects.
%
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


% check input
if isempty(varargin)
    error('need to specify a polygon');
end

var = varargin{1};

% case of a set of polygons stored in a cell array
if iscell(var)
    N = length(var);
    h = zeros(N, 1);
    for i=1:N
        state = ishold(gca);
        hold on;
        % check for empty polygons
        if ~isempty(var{i})
            h(i) = drawPolygon(var{i}, varargin{2:end});
        end
        if ~state
            hold off
        end
    end

    if nargout>0
        varargout{1}=h;
    end

    return;
end


% Extract coordinates of polygon vertices
if size(var, 2)>1
    % first argument is a polygon array
    px = var(:, 1);
    py = var(:, 2);
    varargin(1) = [];
else
    % arguments 1 and 2 correspond to x and y coordinate respectively
    if length(varargin)<2
        error('should specify either a N*2 array, or 2 N*1 vectors');
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
if sum(isnan(px(:)))>0
    polygons = splitPolygons([px py]);
    h = drawPolygon(polygons);

    if nargout>0
        varargout{1}=h;
    end

    return;
end

% ensure last point is the same as the first one
px(size(px, 1)+1, :) = px(1,:);
py(size(py, 1)+1, :) = py(1,:);

% draw the polygon outline
h = plot(px, py, varargin{:});

% format output arg
if nargout>0
    varargout{1}=h;
end
