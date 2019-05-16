function varargout = drawPolygon3d(varargin)
%DRAWPOLYGON3D Draw a 3D polygon specified by a list of vertex coords.
%
%   drawPolygon3d(POLY);
%   packs coordinates in a single N-by-3 array.
%
%   drawPolygon3d(PX, PY, PZ);
%   specifies coordinates in separate numeric vectors (either row or
%   columns)
%
%   drawPolygon3d(..., PARAM, VALUE);
%   Specifies style options to draw the polyline, see plot for details.
%
%   H = drawPolygon3d(...);
%   also returns a handle to the list of created line objects. 
%
%   Example
%     t = linspace(0, 2*pi, 100)';
%     xt = 10 * cos(t);
%     yt = 5 * sin(t);
%     zt = zeros(1,100);
%     figure; drawPolygon3d(xt, yt, zt, 'b');
% 
%   See Also:
%   polygons3d, fillPolygon3d, drawPolyline3d
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2011-08-17 from drawPolyline3d, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% HISTORY
% 2019-02-02 add support for multiple polygons 


%% Process input arguments 

% extract handle of axis to draw on
ax = gca;
var1 = varargin{1};
if isAxisHandle (var1)
    ax          = var1;
    varargin(1) = [];
end

% check case we want to draw several curves, stored in a cell array
var1 = varargin{1};
if iscell(var1)
    hold on;
    h = [];
    for i = 1:length(var1(:))
        h = [h; drawPolygon3d(ax, var1{i}, varargin{2:end})]; %#ok<AGROW>
    end
    if nargout > 0
        varargout{1} = h;
    end
    return;
end

%% extract polygon coordinates
if min(size(var1)) == 1
    % if first argument is a vector (either row or column), then assumes
    % first argument contains x coords, second argument contains y coords
    % and third one the z coords
    px = var1;
    if length(varargin) < 3
        error('geom3d:drawPolygon3d:Wrong number of arguments in fillPolygon3d');
    end
    py = varargin{2};
    pz = varargin{3};
    varargin = varargin(4:end);
else
    % first argument contains both coordinate
    px = var1(:, 1);
    py = var1(:, 2);
    pz = var1(:, 3);
    varargin = varargin(2:end);
end


%% draw the polygon

% check that the polygon is closed
if px(1) ~= px(end) || py(1) ~= py(end) || pz(1) ~= pz(end)
    px = [px(:); px(1)];
    py = [py(:); py(1)];
    pz = [pz(:); pz(1)];
end

% draw the closed curve
h = plot3(ax, px, py, pz, varargin{:});


%% Format output

if nargout > 0
    varargout = {h};
end