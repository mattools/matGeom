function varargout = drawPolygon3d(varargin)
%DRAWPOLYGON3D Draw a 3D polygon specified by a list of vertices
%
%   drawPolygon3d(POLY);
%   packs coordinates in a single N-by-3 array.
%
%   drawPolygon3d(PX, PY, PZ);
%   specifies coordinates in separate arrays.
%
%   drawPolygon3d(..., PARAM, VALUE);
%   Specifies style options to draw the polyline, see plot for details.
%
%   H = drawPolygon3d(...);
%   also return a handle to the list of line objects.
%
%   See Also:
%   polygons3d, fillPolygon3d, drawPolyline3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-08-17 from drawPolyline3d, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% HISTORY
 
   
% check case we want to draw several curves, stored in a cell array
var = varargin{1};
if iscell(var)
    hold on;
    h = [];
    for i = 1:length(var(:))
        h = [h; drawPolygon3d(var{i}, varargin{2:end})]; %#ok<AGROW>
    end
    if nargout > 0
        varargout{1} = h;
    end
    return;
end

% extract curve coordinate
if size(var, 2) == 1
    % first argument contains x coord, second argument contains y coord
    % and third one the z coord
    px = var;
    if length(varargin) < 3
        error('Wrong number of arguments in drawPolygon3d');
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


%% draw the polygon

% check that the polygon is closed
if px(1) ~= px(end) || py(1) ~= py(end) || pz(1) ~= pz(end)
    px = [px; px(1)];
    py = [py; py(1)];
    pz = [pz; pz(1)];
end

% draw the closed curve
h = plot3(px, py, pz, varargin{:});

if nargout > 0
    varargout = {h};
end