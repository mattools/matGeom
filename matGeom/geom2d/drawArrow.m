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
%   return handle(s) to created arrow elements
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

if isempty(varargin)
    error('should specify at least one argument');
end

% parse arrow coordinates
var = varargin{1};
if size(var, 2) == 4
    x1 = var(:,1);
    y1 = var(:,2);
    x2 = var(:,3);
    y2 = var(:,4);
    varargin = varargin(2:end);
    
elseif length(varargin) > 3
    x1 = varargin{1};
    y1 = varargin{2};
    x2 = varargin{3};
    y2 = varargin{4};
    varargin = varargin(5:end);
    
else
    error('MatGeom:drawArrow:invalidArgumentNumber', ...
        'wrong number of arguments, please read the doc');
end

% default values
l = 10 * size(size(x1));
w = 5 * ones(size(x1));
r = zeros(size(x1));

% exctract length of arrow
if ~isempty(varargin)
    l = varargin{1};
    if length(x1) > length(l)
        l = l(1) * ones(size(x1));
    end
end

% extract width of arrow
if length(varargin)>1
    w = varargin{2};
    if length(x1) > length(w)
        w = w(1) * ones(size(x1));
    end
end

% extract 'ratio' of arrow
if length(varargin) > 2
    r = varargin{3};
    if length(x1) > length(r)
        r = r(1) * ones(size(x1));
    end
end

hold on;
oldHold = ishold(gca);
if ~oldHold
    hold on;
end
axis equal;

% angle of the edge
theta = atan2(y2-y1, x2-x1);

% point on the 'left'
xa1 = x2 - r.*l.*cos(theta) - w.*sin(theta)/2;
ya1 = y2 - r.*l.*sin(theta) + w.*cos(theta)/2;
% point on the 'right'
xa2 = x2 - r.*l.*cos(theta) + w.*sin(theta)/2;
ya2 = y2 - r.*l.*sin(theta) - w.*cos(theta)/2;
% point on the middle of the arrow
xa3 = x2 - r.*l.*cos(theta);
ya3 = y2 - r.*l.*sin(theta);

% draw main edge
h1 = line([x1'; x2'], [y1'; y2'], 'color', [0 0 1]);

% draw only 2 wings
ind = find(r==0);
h2 = line([xa1(ind)'; x2(ind)'], [ya1(ind)'; y2(ind)'], 'color', [0 0 1]);
h3 = line([xa2(ind)'; x2(ind)'], [ya2(ind)'; y2(ind)'], 'color', [0 0 1]);

% draw a full arrow
ind = find(r~=0);
h4 = patch([x2(ind) xa1(ind) xa3(ind) xa2(ind) x2(ind)]', ...
    [y2(ind) ya1(ind) ya3(ind) ya2(ind) y2(ind)]', [0 0 1]);
h4(r==0) = 0;

% format output arguments
if nargout > 0
    varargout{1} = [h1 h2 h3 h4];
end

if ~oldHold
    hold off;
end
