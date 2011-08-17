function varargout = drawPolyline3d(varargin)
%DRAWPOLYLINE3D Draw a 3D polyline specified by a list of vertices
%
%   drawPolyline3d(POLY);
%   packs coordinates in a single N-by-3 array.
%
%   drawPolyline3d(PX, PY, PZ);
%   specify coordinates in separate arrays.
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
%   also return a handle to the list of line objects.
%
%   See Also:
%   polygons3d, drawPolygon3d, fillPolygon3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

% HISTORY
% 2010-03-08 rename as drawPolyline3d


%% Process input arguments

% check case we want to draw several curves, stored in a cell array
var = varargin{1};
if iscell(var)
    hold on;
    h = [];
    for i = 1:length(var(:))
        h = [h; drawPolyline3d(var{i}, varargin{2:end})]; %#ok<AGROW>
    end
    if nargout > 0
        varargout = {h};
    end
    return;
end

% extract curve coordinates
if size(var, 2) == 1
    % first argument contains x coord, second argument contains y coord
    % and third one the z coord
    px = var;
    if length(varargin) < 3
        error('Wrong number of arguments in drawPolyline3d');
    end
    py = varargin{2};
    pz = varargin{3};
    varargin = varargin(4:end);
    
else
    % all coordinates are grouped in the first argument
    px = var(:, 1);
    py = var(:, 2);
    pz = var(:, 3);
    varargin = varargin(2:end);
end

% check if curve is closed or open (default is open)
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


%% draw the curve

% for closed curve, add the first point at the end to close curve
if closed
    px = [px; px(1)];
    py = [py; py(1)];
    pz = [pz; pz(1)];
end

h = plot3(px, py, pz, varargin{:});

if nargout > 0
    varargout = {h};
end