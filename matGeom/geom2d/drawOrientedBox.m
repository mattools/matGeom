function varargout = drawOrientedBox(varargin)
%DRAWORIENTEDBOX Draw centered oriented rectangle.
%   
%   Syntax
%   drawOrientedBox(BOX)
%   drawOrientedBox(BOX, 'PropertyName', propertyvalue, ...)
%
%   Description
%   drawOrientedBox(OBOX)
%   Draws an oriented rectangle (or bounding box) on the current axis. 
%   OBOX is a 1-by-5 row vector containing box center, dimension (length
%   and width) and orientation (in degrees): 
%   OBOX = [CX CY LENGTH WIDTH THETA].
%
%   When OBOX is a N-by-5 array, the N boxes are drawn.
%
%   drawOrientedBox(AX, ...) 
%   Specifies the axis to draw to point in. AX should be a handle to a axis
%   object. By default, display on current axis.
%
%   HB = drawOrientedBox(...) 
%   Returns a handle to the created graphic object(s). Object style can be
%   modified using syntaw like:
%   set(HB, 'color', 'g', 'linewidth', 2);
%
%   Example
%     % draw an ellipse together with its oriented box
%     elli = [30 40 60 30 20];
%     figure; 
%     drawEllipse(elli, 'linewidth', 2, 'color', 'g');
%     hold on
%     box = [30 40 120 60 20];
%     drawOrientedBox(box, 'color', 'k');
%     axis equal;
%
%   See also 
%     orientedBox, drawPolygon, drawRect, drawBox, drawCenteredEdge
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-05-09, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

%% Parses input arguments

% extract handle of axis to draw on
[ax, varargin] = parseAxisHandle(varargin{:});

% extract shape primitive
box = varargin{1};
varargin(1) = [];

if length(varargin) > 4 && sum(cellfun(@isnumeric, varargin(1:4))) == 4
    % input given as separate arguments
    cx  = box;
    cy  = varargin{1};
    hl   = varargin{2} / 2;
    hw   = varargin{3} / 2;
    theta   = varargin{4};
    varargin = varargin(5:end);
    
else
    % input given as packed array
    cx  = box(:,1);
    cy  = box(:,2);
    hl   = box(:,3) / 2;
    hw   = box(:,4) / 2;
    theta = box(:,5);
end


%% Pre-processing

% allocate memory for graphical handle
hr = zeros(length(cx), 1);

% save hold state
holdState = ishold(ax);
hold(ax, 'on');


%% Draw each box

% iterate on oriented boxes
for i = 1:length(cx)
    % pre-compute angle data
    cot = cosd(theta(i));
    sit = sind(theta(i));
    
    % x and y shifts
    lc = hl(i) * cot;
    ls = hl(i) * sit;
    wc = hw(i) * cot;
    ws = hw(i) * sit;

    % coordinates of box vertices
    vx = cx(i) + [-lc + ws; lc + ws ; lc - ws ; -lc - ws ; -lc + ws];
    vy = cy(i) + [-ls - wc; ls - wc ; ls + wc ; -ls + wc ; -ls - wc];

    % draw polygons
    hr(i) = plot(ax, vx, vy, varargin{:});
end


%% Post-processing

% restore hold state
if ~holdState
    hold(ax, 'off');
end

% Format output
if nargout > 0
    varargout = {hr};
end
