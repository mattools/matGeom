function varargout = drawGrid(varargin)
%DRAWGRID Draw a grid defined by vertex positions along each axis.
%
%   Usage:
%   drawGrid(LX, LY)
%   [HX, HY] = drawGrid(LX, LY)
%
%   Example
%     % Display a simple grid
%     figure; hold on; axis equal; axis([-2.5 2.5 -2 2]);
%     lx = -2:.5:2; ly = -1.5:.5:1.5;
%     drawGrid(lx, ly, 'k');
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2024-06-28,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE.

%% Extract input arguments
% extract handle of axis to draw on
if isAxisHandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

lx = varargin{1};
ly = varargin{2};
varargin(1:2) = [];

if isempty(varargin)
    varargin = {'k-'};
end


%% Display grid lines

% x-grid
hold on;
lx2 = repmat(lx([1 end])', 1, length(ly));
hx = plot(ax, lx2, [ly ; ly], varargin{:});

% y-grid
ly2 = repmat(ly([1 end])', 1, length(lx));
hy = plot(ax, [lx ; lx], ly2, varargin{:});


%% format output argumenbts
if nargout > 0
    varargout = {hx, hy};
end