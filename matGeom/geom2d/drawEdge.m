function varargout = drawEdge(varargin)
%DRAWEDGE Draw an edge given by 2 points
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
%   See also:
%   edges2d, drawCenteredEdge, drawLine
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   19/02/2004 add support for arrays of edges.
%   31/03/2004 change format of edges to [P1 P2] and variants.
%   28/11/2004 add support for 3D edges
%   01/08/2005 add support for drawing options
%   31/05/2007 update doc, and code makeup
%   03/08/2010 re-organize code

% separate edge and optional arguments
[edge options] = parseInputArguments(varargin{:});

% draw the edges
if size(edge, 2)==4
    h = drawEdge_2d(edge, options);
else
    h = drawEdge_3d(edge, options);
end

% eventually return handle to created edges
if nargout>0
    varargout{1}=h;
end


function h = drawEdge_2d(edge, options)

h = -1*ones(size(edge, 1), 1);

for i=1:size(edge, 1)
    if isnan(edge(i,1))
        continue;
    end
    h(i) = line(...
        [edge(i, 1) edge(i, 3)], ...
        [edge(i, 2) edge(i, 4)], options{:});
end


function h = drawEdge_3d(edge, options)

h = -1*ones(size(edge, 1), 1);

for i=1:size(edge, 1)
    if isnan(edge(i,1))
        continue;
    end
    h(i) = line( ...
        [edge(i, 1) edge(i, 4)], ...
        [edge(i, 2) edge(i, 5)], ...
        [edge(i, 3) edge(i, 6)], options{:});
end

    
function [edge options] = parseInputArguments(varargin)

% default values for parameters
edge = [];

% find the number of arguments defining edges
nbVal=0;
for i=1:nargin
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
if length(options)==1
    options = [{'color'}, options];
end

% extract edges characteristics
if nbVal==1
    % all parameters in a single array
    edge = varargin{1};

elseif nbVal==2
    % parameters are two points, or two arrays of points, of size N*2.
    p1 = varargin{1};
    p2 = varargin{2};
    edge = [p1 p2];
    
elseif nbVal==4
    % parameters are 4 parameters of the edge : x1 y1 x2 and y2
    edge = [varargin{1} varargin{2} varargin{3} varargin{4}];
    
elseif nbVal==6
    % parameters are 6 parameters of the edge : x1 y1 z1 x2 y2 and z2
    edge = [varargin{1} varargin{2} varargin{3} varargin{4} varargin{5} varargin{6}];
end
