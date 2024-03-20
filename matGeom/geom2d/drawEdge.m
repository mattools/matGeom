function varargout = drawEdge(varargin)
%DRAWEDGE Draw an edge defined by its two extremities.
%   
%   drawEdge(x1, y1, x2, y2);
%   draw an edge between the points (x1 y1) and  (x2 y2).
%
%   drawEdge([x1 y1 x2 y2]) ;
%   drawEdge([x1 y1], [x2 y2]);
%   specify data either as bundled edge, or as 2 points
%
%   The function supports 3D edges:
%   drawEdge([x1 y1 z1 x2 y2 z2]);
%   drawEdge([x1 y1 z1], [x2 y2 z2]);
%   drawEdge(x1, y1, z1, x2, y2, z2);
%
%   Arguments can be single values or array of size [N*1]. In this case,
%   the function draws multiple edges.
%
%   H = drawEdge(..., OPT), with OPT being a set of pairwise options, can
%   specify color, line width and so on...
%
%   H = drawEdge(...) return handle(s) to created edges(s)
%
%   See also 
%   edges2d, drawCenteredEdge, drawLine
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

% separate edge and optional arguments
[ax, edge, options] = parseInputArguments(varargin{:});

% save hold state
holdState = ishold(ax);
hold(ax, 'on');

% draw the edges
if size(edge, 2) == 4
    h = drawEdge_2d(ax, edge, options);
else
    h = drawEdge_3d(ax, edge, options);
end

% restore hold state
if ~holdState
    hold(ax, 'off');
end

% eventually return handle to created edges
if nargout > 0
    varargout = {h};
end


function h = drawEdge_2d(ax, edge, options)

h = -1 * ones(size(edge, 1), 1);

for i = 1:size(edge, 1)
    if isnan(edge(i,1))
        continue;
    end
    
    h(i) = plot(ax, edge(i, [1 3]), edge(i, [2 4]), options{:});
end


function h = drawEdge_3d(ax, edge, options)

h = -1 * ones(size(edge, 1), 1);

for i = 1:size(edge, 1)
    if isnan(edge(i,1))
        continue;
    end
    
    h(i) = plot3(ax, edge(i, [1 4]), edge(i, [2 5]), edge(i, [3 6]), options{:});
end

    
function [ax, edge, options] = parseInputArguments(varargin)

% extract handle of axis to draw on
[ax, varargin] = parseAxisHandle(varargin{:});

% find the number of arguments defining edges
nbVal = 0;
for i = 1:length(varargin)
    if isnumeric(varargin{i})
        nbVal = nbVal+1;
    else
        % stop at the first non-numeric value
        break;
    end
end

% extract drawing options
options = varargin(nbVal+1:end);

% ensure drawing options have correct format
if length(options) == 1
    options = [{'color'}, options];
end

% extract edges characteristics
switch nbVal
    case 1
        % all parameters in a single array
        edge = varargin{1};
        
    case 2
        % parameters are two points, or two arrays of points, of size N*2.
        p1 = varargin{1};
        p2 = varargin{2};
        edge = [p1 p2];
        
    case 4
        % parameters are 4 parameters of the edge : x1 y1 x2 and y2
        edge = [varargin{1} varargin{2} varargin{3} varargin{4}];
        
    case 6
        % parameters are 6 parameters of the edge : x1 y1 z1 x2 y2 and z2
        edge = [varargin{1} varargin{2} varargin{3} varargin{4} varargin{5} varargin{6}];
        
    otherwise
        error('drawEdge:WrongNumberOfParameters', 'Wrong number of parameters');
end
