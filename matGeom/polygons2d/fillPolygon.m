function varargout = fillPolygon(varargin)
%FILLPOLYGON Fill a polygon specified by a list of points
%
%   fillPolygon(POLY);
%   Fills the interior of the polygon specified by POLY. The boundary of
%   the polygon is not drawn, see 'drawPolygon' to do it.
%   POLY is a single [N*2] array.
%   If POLY contains NaN-couples, each portion between the [NaN;NaN] will
%   be filled separately.
%
%   fillPolygon(PX, PY);
%   Specifies coordinates of the polygon in separate arrays.
%
%
%   H = fillPolygon(...);
%   Also returns a handle to the created patch
%
%
%   See also:
%   polygons2d, drawCurve, drawPolygon
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2005.
%

%   HISTORY
%   2008-05-07 add psb to specify drawing options
%   2008/10/15 add psb to draw polygons with holes

% check input
if isempty(varargin)
    error('need to specify a polygon');
end

% case of a set of polygons stored in a cell array
var = varargin{1};
if iscell(var)
    N = length(var);
    h = zeros(N, 1);
    for i=1:N
        % check for empty polygons
        if ~isempty(var{i})
            h(i) = fillPolygon(var{i}, varargin{2:end});
        end
    end

    % setup output values
    if nargout>0
        varargout{1}=h;
    end
    return;
end

% Extract coordinates of polygon vertices
if size(var, 2)>1
    % first argument is a polygon array
    px = var(:, 1);
    py = var(:, 2);
    varargin(1) = [];
else
    % arguments 1 and 2 correspond to x and y coordinate respectively
    if length(varargin)<2
        error('should specify either a N*2 array, or 2 N*1 vectors');
    end
    
    px = varargin{1};
    py = varargin{2};
    varargin(1:2) = [];
end


% Find position of breaks, and copies first point of each loop at the
% end
inds = find(isnan(px(:)));
i1 = [inds ; length(px)+1];
i0 = [1 ; inds+1];
px(i1, :) = px(i0, :);
py(i1, :) = py(i0, :);


% set default line format
if isempty(varargin)
    varargin = {'b'};
end


% fill the polygon with desired style
h = fill(px, py, varargin{:}, 'lineStyle', 'none');

% output
if nargout>0
    varargout{1}=h;
end
