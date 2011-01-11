function varargout = drawCurve3d(varargin)
%DRAWCURVE3D draw a 3D curve specified by a list of points
%
%   drawCurve3d(COORD) packs coordinates in a single [N*3] array.
%
%   drawCurve3d(PX, PY, PZ) specify coordinates in separate arrays.
%
%   H = drawCurve3d(...) also return a handle to the list of line objects.
%
%   See Also :
%   drawPolygon
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

% HISTORY
% 2010-03-08 rename to drawPolyline3d

% deprecation warning
warning('geom3d:deprecated', ...
    '''drawCurve3d'' is deprecated, use ''drawPolyline3d'' instead');

% default value for closed or open curve
closed = false;
   
% check case we want to draw several curves, stored in a cell array
var = varargin{1};
if iscell(var)
    hold on;
    h = [];
    for i=1:length(var(:))
        h = [h; drawCurve3d(var{i}, varargin{2:end})];
    end
    if nargout>0
        varargout{1}=h;
    end
    return;
end

% extract curve coordinate
if size(var, 2)==1
    % first argument contains x coord, second argument contains y coord
    % and third one the z coord
    px = var;
    if length(varargin)<3
        error('Wrong number of arguments in drawCurve3d');
    end
    py = varargin{2};
    pz = varargin{3};
    varargin = varargin(4:end);
else
    % first argument contains both coordinate
    px = var(:, 1);
    py = var(:, 2);
    pz = var(:, 3);
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

% for closed curve, add the first point at the end to close curve
if closed
    px = [px; px(1)];
    py = [py; py(1)];
    pz = [pz; pz(1)];
end

%% draw the curve ! !! ! ! 
h = plot3(px, py, pz, varargin{:});

if nargout>0
    varargout{1}=h;
end