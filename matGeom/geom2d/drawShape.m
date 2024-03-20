function varargout = drawShape(varargin)
%DRAWSHAPE Draw various types of shapes (circles, polygons...).
%
%   drawShape(TYPE, PARAM)
%   Draw the shape of type TYPE, specified by given parameter PARAM. TYPE
%   can be one of {'circle', 'ellipse', 'rect', 'polygon', 'curve'}
%   PARAM depend on the type. For example, if TYPE is 'circle', PARAM will
%   contain [x0 y0 R].
%
%   Examples:
%   drawShape('circle', [20 10 30]);
%   Draw circle centered on [20 10] with radius 10.
%   drawShape('rect', [20 20 40 10 pi/3]);
%   Draw rectangle centered on [20 20] with length 40 and width 10, and
%   oriented pi/3 wrt axis Ox.
%   
%
%   drawShape(..., OPTION)
%   also specifies drawing options. OPTION can be 'draw' (default) or
%   'fill'.
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2005-04-07
% Copyright 2005-2023 INRA - TPV URPOI - BIA IMASTE

% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% extract type and representation of shape
type = varargin{1};
param = varargin{2};
varargin(1:2) = [];


if ~iscell(type)
    type = {type};
end
if ~iscell(param)
    tmp = cell(1, size(param, 1));
    for i=1:size(param, 1)
        tmp{i} = param(i,:);
    end
    param = tmp;
end

% compute drawing options
option = 'draw';
if ~isempty(varargin)
    var = varargin{1};
    if strcmpi(var, 'fill')
        option = 'fill';
        varargin(1) = [];
    elseif strcmpi(var, 'draw')
        option = 'draw';
        varargin(1) = [];
    end
end

    
% transform each shape into a polygon
shape = cell(1,length(type));
for i = 1:length(type)    
    if strcmpi(type{i}, 'circle')
        shape{i} = circleToPolygon(param{i}, 128);
    elseif strcmpi(type{i}, 'rect')
        shape{i} = rectToPolygon(param{i});
    elseif strcmpi(type{i}, 'polygon')
        shape{i} = param{i};        
    end
end


% draw or fill each shape as polygon
hold on;
h = zeros(length(shape), 1);
if strcmp(option, 'draw')
    for i = 1:length(shape)
        h(i) = drawPolygon(ax, shape{i}, varargin{:});
    end
else
    for i = 1:length(shape)
        h(i) = fillPolygon(ax, shape{i}, varargin{:});
    end
end

% format output
if nargout > 0
    varargout = {h};
end
