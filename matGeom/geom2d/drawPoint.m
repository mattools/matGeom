function varargout = drawPoint(varargin)
%DRAWPOINT Draw the point on the axis.
%
%   drawPoint(X, Y);
%   Draws points defined by coordinates X and Y.
%   X and Y should be array the same size.
%
%   drawPoint(COORD);
%   Packs coordinates in a single N-by-2 array.
%
%   drawPoint(..., OPT);
%   Draws each point with given option. OPT is a series of arguments pairs
%   compatible with 'plot' model. Default drawing option is 'bo',
%   corresponding to blue circles.
%
%   drawPoint(AX, ...);
%   Specifies the axis to draw to point in. AX should be a handle to a axis
%   object. By default, display on current axis.
%
%   H = drawPoint(...) also return a handle to each of the drawn points.
%
%   Example
%     % display a single point
%     figure;
%     drawPoint([10 10]);
%
%     % display several points forming a circle
%     t = linspace(0, 2*pi, 20)';
%     drawPoint([5*cos(t)+10 3*sin(t)+10], 'r+');
%     axis equal;
%
%   See also
%   points2d, clipPoints
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   23/02/2004 add more documentation. Manage different kind of inputs. 
%     Does not draw points outside visible area.
%   26/02/2007 update processing of input arguments.
%   30/04/2009 remove clipping of points (use clipPoints if necessary)
%   2011-10-11 add management of axes handle

% extract handle of axis to draw on
if isscalar(varargin{1}) && ishandle(varargin{1})
    ax = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% extract point(s) coordinates
var = varargin{1};
if size(var, 2) == 1
    % points stored in separate arrays
    px = varargin{1};
    py = varargin{2};
    varargin(1:2) = [];
else
    % points packed in one array
    px = var(:, 1);
    py = var(:, 2);
    varargin(1) = [];
end

% ensure we have column vectors
px = px(:);
py = py(:);

% default drawing options, but keep specified options if it has the form of
% a bundled string
if length(varargin) ~= 1
    varargin = [{'linestyle', 'none', 'marker', 'o', 'color', 'b'}, varargin];
end

% plot the points, using specified drawing options
h = plot(ax, px(:), py(:), varargin{:});

% process output arguments
if nargout > 0
    varargout = {h};
end
