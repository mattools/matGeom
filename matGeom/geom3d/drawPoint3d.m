function varargout = drawPoint3d(varargin)
%DRAWPOINT3D Draw 3D point on the current axis.
%
%   drawPoint3d(X, Y, Z) 
%   will draw points defined by coordinates X and Y. 
%   X and Y are N*1 array, with N being number of points to be drawn.
%   
%   drawPoint3d(COORD) 
%   packs coordinates in a single [N*3] array.
%
%   drawPoint3d(..., OPT) 
%   will draw each point with given option. OPT is a string compatible with
%   'plot' model.
%
%   H = drawPoint3d(...) 
%   Also return a handle to each of the drawn points.
%
%   
%   See also
%   points3d, clipPoints3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   04/01/2007: remove unused variables, and enhance support for plot
%       options
%   12/02/2010 does not clip points anymore


var = varargin{1};
if size(var, 2)==3
    % points are given as one single array with 3 columns
    px = var(:, 1);
    py = var(:, 2);
    pz = var(:, 3);
    varargin = varargin(2:end);
elseif length(varargin)<3
    error('wrong number of arguments in drawPoint3d');
else
    % points are given as 3 columns with equal length
    px = varargin{1};
    py = varargin{2};
    pz = varargin{3};
    varargin = varargin(4:end);
end

% default draw style: no line, marker is 'o'
if length(varargin)~=1
    varargin = ['linestyle', 'none', 'marker', 'o', varargin];
end

% plot only points inside the axis.
h = plot3(px, py, pz, varargin{:});

if nargout>0
    varargout{1} = h;
end
