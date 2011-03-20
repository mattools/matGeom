function varargout = drawLine3d(lin, varargin)
%DRAWLINE3D Draw a 3D line on the current axis
%
%   drawline3d(LINE);
%   Draws the line LINE on the current axis, by clipping with the current
%   axis. If line is not clipepd by the axis, function return -1.
%
%   drawLine3d(LINE, PARAM, VALUE)
%   Accepts parameter/value pairs, like for plot function.
%   Color of the line can also be given as a single parameter.
%   
%   H = drawLine3d(...)
%   Returns a handle to the created graphic line object.
%
%
%   See also:
%   lines3d, createLine3d, clipLine3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005.
%

%   HISTORY
%   30/10/2008 replace intersectPlaneLine by intersectLinePlane


% ensure color is given as name-value pair
if length(varargin)==1
    varargin = {'color', varargin{1}};
end

% extract limits of the bounding box
lim = get(gca, 'xlim');
xmin = lim(1);
xmax = lim(2);
lim = get(gca, 'ylim');
ymin = lim(1);
ymax = lim(2);
lim = get(gca, 'zlim');
zmin = lim(1);
zmax = lim(2);

% clip the ine with the limits of the current axis
edge = clipLine3d(lin, [xmin xmax ymin ymax zmin zmax]);

% draw the clipped line
if sum(isnan(edge))==0
    h  = drawEdge3d(edge);
    if ~isempty(varargin)
        set(h, varargin{:});
    end
else
    h  = -1;
end

% process output
if nargout>0
    varargout{1}=h;
end