function h = drawLine3d(lin, varargin)
%DRAWLINE3D Draw a 3D line clipped by the current axes.
%
%   drawLine3d(LINE) draws the line LINE on the current axis, by clipping 
%   with the current axis.
%
%   drawLine3d(LINE, PARAM, VALUE) accepts parameter/value pairs, like 
%   for plot function. Color of the line can also be given as a single 
%   parameter.
%
%   drawLine3d(AX,...) plots into AX instead of GCA.
%   
%   H = drawLine3d(...) returns a handle to the created line object. 
%   If the line is not clipped by the axis, function returns -1.
%
%   Example
%     % draw a sphere together with the three main axes
%     figure; hold on;
%     drawSphere([40 30 20 30]);
%     view(3); axis equal; axis([-20 80 -20 80 -20 80])
%     drawLine3d([0 0 0   1 0 0], 'k');
%     drawLine3d([0 0 0   0 1 0], 'k');
%     drawLine3d([0 0 0   0 0 1], 'k');
%     light;
%
%
%   See also:
%     lines3d, createLine3d, clipLine3d
%

% ---------
% author : David Legland 
% INRA - TPV URPOI - BIA IMASTE
% created the 17/02/2005.


% Parse and check inputs
isLine3d = @(x) validateattributes(x,{'numeric'},...
    {'nonempty','nonnan','real','finite','size',[nan,6]});
defOpts.Color = 'b';
[hAx, lin, varargin] = ...
    parseDrawInput(lin, isLine3d, 'line', defOpts, varargin{:});

% extract limits of the bounding box
box = [get(gca, 'xlim') get(gca, 'ylim') get(gca, 'zlim')];

% clip the line with the limits of the current axis
edge = clipLine3d(lin, box);

% draw the clipped line
if sum(isnan(edge)) == 0
    hh = drawEdge3d(hAx, edge);
    if ~isempty(varargin)
        set(hh, varargin{:});
    end
else
    hh = [];
end

% process output
if nargout > 0
    h = hh;
end
