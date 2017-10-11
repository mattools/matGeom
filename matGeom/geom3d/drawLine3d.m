function varargout = drawLine3d(lin, varargin)
%DRAWLINE3D Draw a 3D line clipped by the current axes
%
%   DRAWLINE3D(LINE) draws the line LINE on the current axis, by clipping 
%   with the current axis.
%
%   DRAWLINE3D(LINE, PARAM, VALUE) accepts parameter/value pairs, like 
%   for plot function. Color of the line can also be given as a single 
%   parameter.
%
%   DRAWLINE3D(AX,...) plots into AX instead of GCA.
%   
%   H = DRAWLINE3D(...) returns a handle to the created line object. 
%   If the line is not clipped by the axis, function returns -1.
%
%   See also:
%   lines3d, createLine3d, clipLine3d
%
% ---------
% author : David Legland 
% INRA - TPV URPOI - BIA IMASTE
% created the 17/02/2005.
%

% Parse and check inputs
if numel(lin) == 1 && ishandle(lin)
    hAx = lin;
    lin = varargin{1};
    varargin(1) = [];
else
    hAx = gca;
end

% parse input arguments if there are any
if ~isempty(varargin)
    if length(varargin) == 1
        if isstruct(varargin{1})
            % if options are specified as struct, need to convert to 
            % parameter name-value pairs
            varargin = [fieldnames(varargin{1}) struct2cell(varargin{1})]';
            varargin = varargin(:)';
        else
            % if option is a single argument, assume it corresponds to 
            % plane color
            varargin = {'Color', varargin{1}};
        end
    end
end

% extract limits of the bounding box
lim = get(hAx, 'xlim');
xmin = lim(1);
xmax = lim(2);
lim = get(hAx, 'ylim');
ymin = lim(1);
ymax = lim(2);
lim = get(hAx, 'zlim');
zmin = lim(1);
zmax = lim(2);

% clip the line with the limits of the current axis
edge = clipLine3d(lin, [xmin xmax ymin ymax zmin zmax]);

% draw the clipped line
if sum(isnan(edge))==0
    h  = drawEdge3d(hAx, edge);
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