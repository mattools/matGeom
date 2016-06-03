function varargout = drawArrow(varargin)
%DRAWARROW Draw an arrow on the current axis
%   
%   drawArrow(x1, y1, x2, y2) 
%   draws an arrow between the points (x1 y1) and (x2 y2).
%
%   drawArrow([x1 y1 x2 y2])
%   gives argument as a single array.
%
%   drawArrow(..., L, W)
%   specifies length and width of the arrow.
%
%   drawArrow(..., L, W, TYPE)
%   also specifies arrow type. TYPE can be one of the following :
%   0: draw only two strokes
%   1: fill a triangle
%   .5: draw a half arrow (try it to see ...)
%   
%   Arguments can be single values or array of size N-by-1. In this case,
%   the function draws multiple arrows.
%
%   H = drawArrow(...) 
%   return handle(s) to created arrow elements.
%   The handles are returned in a structure with the fields
%   'body', 'wing' and 'head' containing the handles to the different
%   parts of the arrow(s).
%
%   Example
%     t = linspace(0, 2*pi, 200);
%     figure; hold on;
%     plot(t, sin(t)); 
%     drawArrow([2 -1 pi 0], .1, .05, .5)
% 
%   See also
%     drawEdge
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/11/2004 from drawEdge
%

%   HISTORY
%   2014-09-17 fix managment of handle values as suggested by Benoit Botton
%   2016-05-23 Improve codee and reduce calculations (by JuanPi Carbajal)

if isempty (varargin)
    error ('should specify at least one argument');
end

% parse arrow coordinates
var = varargin{1};
if size (var, 2) == 4
    x1 = var(:,1);
    y1 = var(:,2);
    x2 = var(:,3);
    y2 = var(:,4);
    varargin = varargin(2:end);

elseif length (varargin) > 3
    x1 = varargin{1};
    y1 = varargin{2};
    x2 = varargin{3};
    y2 = varargin{4};
    varargin = varargin(5:end);
    
else
    error ('MatGeom:drawArrow:invalidArgumentNumber', ...
        'wrong number of arguments, please read the doc');
end
N     = size (x1, 1);

% default values
l = 10  * ones (N, 1); % Body length
w = 5   * ones (N, 1); % Head width
r = 0.1 * ones (N, 1); % Head to body ratio
h = zeros (N, 1);      % Head type

if ~isempty (varargin)
    % Parse parameters
    k      = length (varargin);
    vartxt = 'lwrh';
    cmd    = ['%s = varargin{%d}; %s = %s(:);' ...
              'if length (%s) < N; %s = %s(1) * ones (N , 1); end'];
    for i = 1:k
        v = vartxt(i);
        eval (sprintf (cmd, v, i, v, v, v, v, v));
    end
end

hold on;
oldHold = ishold (gca);
if ~oldHold
    hold on;
end
axis equal;

% angle of the edge
theta = atan2 (y2-y1, x2-x1);

rl = r .* l;
rh = r .* h;
cT = cos (theta);
sT = sin (theta);
% point on the 'left'
xa1 = x2 - rl .* cT - w .* sT / 2;
ya1 = y2 - rl .* sT + w .* cT / 2;
% point on the 'right'
xa2 = x2 - rl .* cT + w .* sT / 2;
ya2 = y2 - rl .* sT - w .* cT / 2;
% point on the middle of the arrow
xa3 = x2 - rh .* cT;
ya3 = y2 - rh .* sT;

% draw main edge
tmp         = line ([x1.'; x2.'], [y1.'; y2.'], 'color', [0 0 1]);
handle.body = tmp;

% draw only 2 wings
ind = find (h == 0);
if ~isempty (ind)
    tmp              = line ([xa1(ind).'; x2(ind).'], [ya1(ind).'; y2(ind).'], ...
                             'color', [0 0 1]);
    handle.wing(:,1) = tmp;

    tmp              = line ([xa2(ind).'; x2(ind).'], [ya2(ind).'; y2(ind).'], ...
                             'color', [0 0 1]);
    handle.wing(:,2) = tmp;
end

% draw a full arrow
ind = find (h ~= 0);
if ~isempty (ind)
    tmp         = patch ([x2(ind) xa1(ind) xa3(ind) xa2(ind) x2(ind)].', ...
                         [y2(ind) ya1(ind) ya3(ind) ya2(ind) y2(ind)].', [0 0 1]);
    handle.head = tmp;
end

% format output arguments
if nargout > 0
    varargout{1} = handle;
end

if ~oldHold
    hold off;
end
