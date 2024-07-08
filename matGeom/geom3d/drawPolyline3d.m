function varargout = drawPolyline3d(varargin)
%DRAWPOLYLINE3D Draw a 3D polyline specified by a list of vertex coords.
%
%   drawPolyline3d(POLY);
%   packs coordinates in a single N-by-3 array.
%
%   drawPolyline3d(PX, PY, PZ);
%   specifies coordinates in separate numeric vectors (either row or
%   columns)
%
%   drawPolyline3d(..., CLOSED);
%   Specifies if the polyline is closed or open. CLOSED can be one of:
%   - 'closed'
%   - 'open'    (the default)
%   - a boolean variable with value TRUE for closed polylines.
%
%   drawPolyline3d(..., PARAM, VALUE);
%   Specifies style options to draw the polyline, see plot for details.
%
%   H = drawPolyline3d(...);
%   also returns a handle to the list of created line objects.
%
%   Example
%     t = linspace(0, 2*pi, 100)';
%     xt = 10 * cos(t);
%     yt = 5 * sin(t);
%     zt = zeros(1,100);
%     figure; drawPolyline3d(xt, yt, zt, 'b');
% 
%   See also 
%   polygons3d, drawPolygon3d, fillPolygon3d
%

% ------
% Author : David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-02-15
% Copyright 2005-2024 INRA - TPV URPOI - BIA IMASTE

%% Process input arguments

% extract handle of axis to draw on
[hAx, varargin] = parseAxisHandle(varargin{:});

% check case we want to draw several curves, stored in a cell array
var = varargin{1};
if iscell(var)
    hold on;
    nPolys = length(var(:));
    h = gobjects(1, nPolys);
    for i = 1:nPolys
        h(i) = drawPolyline3d(hAx, var{i}, varargin{2:end});
    end
    if nargout > 0
        varargout = {h};
    end
    return;
end

% extract vertex coordinates
if min(size(var)) == 1
    % if first argument is a vector (either row or column), then assumes
    % first argument contains x coords, second argument contains y coords
    % and third one the z coords
    px = var;
    if length(varargin) < 3
        error('geom3d:drawPolyline3d:Wrong number of arguments in drawPolyline3d');
    end
    if  isnumeric(varargin{2}) && isnumeric(varargin{3})
        py = varargin{2};
        pz = varargin{3};
        varargin(1:3) = [];
    else
        px = var(:, 1);
        py = var(:, 2);
        pz = var(:, 3);
        varargin(1) = [];
    end
else
    % all coordinates are grouped in the first argument
    px = var(:, 1);
    py = var(:, 2);
    pz = var(:, 3);
    varargin(1) = [];
end

% check if polyline is closed or open (default is open)
closed = false;
if ~isempty(varargin)
    var = varargin{1};
    if islogical(var)
        % check boolean flag
        closed = var;
        varargin = varargin(2:end);
        
    elseif ischar(var)
        % check string indicating close or open
        if strncmpi(var, 'close', 5)
            closed = true;
            varargin = varargin(2:end);
            
        elseif strncmpi(var, 'open', 4)
            closed = false;
            varargin = varargin(2:end);
        end
        
    end
end


%% draw the polyline curve

% for closed curve, add the first point at the end to close curve
if closed
    px = [px(:); px(1)];
    py = [py(:); py(1)];
    pz = [pz(:); pz(1)];
end

h = plot3(hAx, px, py, pz, varargin{:});

if nargout > 0
    varargout = {h};
end
