function varargout = drawLine(lin, varargin)
%DRAWLINE Draw the line on the current axis
%
%   drawline(LINE);
%   Draws the line LINE on the current axis, by using current axis to clip
%   the line. 
%
%   drawline(LINE, PARAM, VALUE);
%   Specifies drawing options.
%
%   H = drawLine(...)
%   Returns a handle to the created line object. If clipped line is not
%   contained in the axis, the function returns -1.
%   
%   Example
%     figure; hold on; axis equal;
%     axis([0 100 0 100]);
%     drawLine([30 40 10 20]);
%     drawLine([30 40 20 -10], 'color', 'm', 'linewidth', 2);
%     drawLine([-30 140 10 20]);
%
%   See also:
%   lines2d, createLine, drawEdge
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   25/05/2004 add support for multiple lines (loop)
%   23/05/2005 add support for arguments
%   03/08/2010 bug for lines outside box (thanks to Reto Zingg)
%   04/08/2010 rewrite using clipLine
%   2011-10-11 add management of axes handle

% extract handle of axis to draw in
if isscalar(lin) && ishandle(lin)
    ax = lin;
    lin = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% default style for drawing lines
varargin = [{'color', 'b'}, varargin];

% extract bounding box of the current axis
xlim = get(ax, 'xlim');
ylim = get(ax, 'ylim');

% clip lines with current axis box
clip = clipLine(lin, [xlim ylim]);
ok   = isfinite(clip(:,1));

% initialize result array to invalide handles
h = -1*ones(size(lin, 1), 1);

% draw valid lines
h(ok) = plot(ax, clip(ok, [1 3])', clip(ok, [2 4])', varargin{:});

% return line handle if needed
if nargout > 0
    varargout = {h};
end
