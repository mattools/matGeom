function varargout = drawEdge3d(varargin)
%DRAWEDGE3D Draw 3D edge in the current Window
%
%   drawEdge(EDGE)
%   draw the edge EDGE on the current axis. EDGE has the form:
%   [x1 y1 z1 x2 y2 z2].
%   No clipping is performed.
%
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.

%   HISTORY
%   04/01/2007 remove unused variables
%   15/12/2009 "reprecate", and add processing of input arguments

% extract edges from input arguments
nCol = size(varargin{1}, 2);
if nCol==6
    % all parameters in a single array
    edges = varargin{1};
    options = varargin(2:end);
elseif nCol==3
    % parameters are two points, or two arrays of points, of size N*3.
    edges = [varargin{1} varargin{2}];
    options = varargin(3:end);
elseif nCol==6
    % parameters are 6 parameters of the edge : x1 y1 z1 x2 y2 and z2
    edges = [varargin{1} varargin{2} varargin{3} varargin{4} varargin{5} varargin{6}];
    options = varargin(7:end);
end

% draw edges
h = line(   [edges(:, 1) edges(:, 4)]', ...
            [edges(:, 2) edges(:, 5)]', ...
            [edges(:, 3) edges(:, 6)]', 'color', 'b');
    
% apply optional drawing style
if ~isempty(options)
    set(h, options{:});
end

% return handle to created Edges
if nargout>0
    varargout{1}=h;
end