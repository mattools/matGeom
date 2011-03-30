function varargout = drawArrow(varargin)
%DRAWARROW Draw an arrow on the current axis
%   
%   DRAWARROW(x1, y1, x2, y2) 
%   draw an arrow between the points (x1 y1) and (x2 y2).
%
%   DRAWARROW([x1 y1 x2 y2])
%   gives argument as a single array.
%
%   DRAWARROW(..., L, W)
%   specify length and width of the arrow.
%
%   DRAWARROW(..., L, W, TYPE)
%   also specify arrow type. TYPE can be one of the following :
%   0: draw only two strokes
%   1: fill a triangle
%   .5: draw a half arrow (try it to see ...)
%   
%   Arguments can be single values or array of size [N*1]. In this case,
%   the function draws multiple arrows.
%
%
%   H = DRAWARROW(...) return handle(s) to created edges(s)
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/11/2004 from drawEdge
%

%   HISTORY


if isempty(varargin)
    error('should specify at least one argument');
end

% parse arrow coordinate
var = varargin{1};
if size(var, 2)==4
    x1 = var(:,1);
    y1 = var(:,2);
    x2 = var(:,3);
    y2 = var(:,4);
    varargin = varargin(2:end);
elseif length(varargin)>3
    x1 = varargin{1};
    y1 = varargin{2};
    x2 = varargin{3};
    y2 = varargin{4};
    varargin = varargin(5:end);
else
    error('wrong number of arguments, please read the doc');
end

l = 10*size(size(x1));
w = 5*ones(size(x1));
h = zeros(size(x1));

% exctract length of arrow
if ~isempty(varargin)
    l = varargin{1};
    if length(x1)>length(l)
        l = l(1)*ones(size(x1));
    end
end

% extract width of arrow
if length(varargin)>1
    w = varargin{2};
    if length(x1)>length(w)
        w = w(1)*ones(size(x1));
    end
end

% extract 'ratio' of arrow
if length(varargin)>2
    h = varargin{3};
    if length(x1)>length(h)
        h = h(1)*ones(size(x1));
    end
end

hold on;
axis equal;

% angle of the edge
theta = atan2(y2-y1, x2-x1);

% point on the 'left'
xa1 = x2 - l.*cos(theta) - w.*sin(theta)/2;
ya1 = y2 - l.*sin(theta) + w.*cos(theta)/2;
% point on the 'right'
xa2 = x2 - l.*cos(theta) + w.*sin(theta)/2;
ya2 = y2 - l.*sin(theta) - w.*cos(theta)/2;
% point on the middle of the arrow
xa3 = x2 - l.*cos(theta).*h;
ya3 = y2 - l.*sin(theta).*h;

% draw main edge
line([x1'; x2'], [y1'; y2'], 'color', [0 0 1]);

% draw only 2 wings
ind = find(h==0);
line([xa1(ind)'; x2(ind)'], [ya1(ind)'; y2(ind)'], 'color', [0 0 1]);
line([xa2(ind)'; x2(ind)'], [ya2(ind)'; y2(ind)'], 'color', [0 0 1]);

% draw a full arrow
ind = find(h~=0);
patch([x2(ind) xa1(ind) xa3(ind) xa2(ind) x2(ind)]', ...
    [y2(ind) ya1(ind) ya3(ind) ya2(ind) y2(ind)]', [0 0 1]);
   

if nargout>0
    varargout{1}=h;
end
