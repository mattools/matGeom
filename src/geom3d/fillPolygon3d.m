function varargout = fillPolygon3d(varargin)
%FILLPOLYGON3D Fill a 3D polygon specified by a list of points
%
%   fillPolygon3d(COORD, COLOR)
%   packs coordinates in a single [N*3] array.
%   COORD can also be a cell array of polygon, in this case each polygon is
%   drawn using the same color.
%
%   fillPolygon3d(PX, PY, PZ, COLOR)
%   specify coordinates in separate arrays.
%
%   fillPolygon3d(..., PARAM, VALUE)
%   allow to specify some drawing parameter/value pairs as for the plot
%   function.
%
%   H = fillPolygon3d(...) also return a handle to the list of line objects.
%
%   See Also:
%   polygons3d, drawPolygon, drawPolyline3d
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2007-01-05
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

    
% check case we want to draw several curves, stored in a cell array
var = varargin{1};
if iscell(var)
    hold on;
    h = [];
    for i=1:length(var(:))
        h = [h; fillPolygon3d(var{i}, varargin{2:end})];
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
        error('Wrong number of arguments in fillPolygon3d');
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

% extract color information
if isempty(varargin)
    color = 'c';
else
    color = varargin{1};
    varargin = varargin(2:end);
end

% ensure polygon is closed
px = [px; px(1)];
py = [py; py(1)];
pz = [pz; pz(1)];

% fill the polygon
h = fill3(px, py, pz, color, varargin{:});

if nargout>0
    varargout{1}=h;
end