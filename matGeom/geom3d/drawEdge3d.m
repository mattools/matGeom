function varargout = drawEdge3d(varargin)
%DRAWEDGE3D Draw 3D edge in the current axes.
%
%   drawEdge3d(EDGE) draws the edge EDGE on the current axis. 
%   EDGE has the form: [x1 y1 z1 x2 y2 z2]. No clipping is performed.
%   
%   drawEdge3d(AX,...) plots into AX instead of GCA.
%
%   H = drawEdge3d(...) returns a handle H to the line object.
%
%   Example
%     figure; axis equal; view(3)
%     p1 = [10 20 80];
%     p2 = [80 10 20];
%     p3 = [20 50 10];
%     drawEdge3d(gca, [p1;p2],[p2;p3],'b');
%     drawEdge3d([p1;p3],'k');
%     pause(1)
%     drawEdge3d(gca, [p1 p2; p2 p3],'g');
%     drawEdge3d(p1(1), p1(2), p1(3),p3(1), p3(2), p3(3),'Color','r','Marker','x');
%
%   See also
%   drawLine3d, clipLine3d, drawEdge
%   
% ---------
% author : David Legland 
% INRA - TPV URPOI - BIA IMASTE
% created the 18/02/2005.
%   
%   HISTORY
%   04/01/2007 remove unused variables
%   15/12/2009 "reprecate", and add processing of input arguments

% Parse and check inputs
if isAxisHandle(varargin{1})
    hAx = varargin{1};
    varargin(1) = [];
else
    hAx = gca;
end

% extract edges from input arguments
nCol = size(varargin{1}, 2);
if nCol == 6
    % all parameters in a single array
    edges = varargin{1};
    varargin(1) = [];
elseif nCol == 3
    if isequal(size(varargin{1}), [2 3]) && length(varargin) == 1
        % parameters are two points given as 2x3
        edges = [varargin{1}(1,:) varargin{1}(2,:)];
    elseif isequal(size(varargin{1}), [2 3]) && ~isnumeric(varargin{2})
        % parameters are two points given as 2x3
        edges = [varargin{1}(1,:) varargin{1}(2,:)];
        varargin(1) = [];
    else
        % parameters are two points, or two arrays of points, of size N*3.
        edges = [varargin{1} varargin{2}];
        varargin(1:2) = [];
    end
elseif nargin >= 6
    % parameters are 6 parameters of the edge : x1 y1 z1 x2 y2 and z2
    edges = [varargin{1} varargin{2} varargin{3} varargin{4} varargin{5} varargin{6}];
    varargin(1:6) = [];
end

% Parse and check inputs
isEdge3d = @(x) validateattributes(x,{'numeric'},...
    {'nonempty','size',[nan,6]});
defOpts.Color = 'b';
[~, edges, varargin] = ...
    parseDrawInput(edges, isEdge3d, 'line', defOpts, varargin{:});

% identify indices of valid edge (not containing any NaN's).
inds = sum(isnan(edges), 2) == 0;

% draw edges
h = line(...
    [edges(inds, 1) edges(inds, 4)]', ...
    [edges(inds, 2) edges(inds, 5)]', ...
    [edges(inds, 3) edges(inds, 6)]', varargin{:}, ...
    'Parent', hAx);

% return handle to created Edges
if nargout > 0
    varargout = {h};
end
