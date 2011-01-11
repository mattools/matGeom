function varargout = drawRay(ray, varargin)
%DRAWRAY draw a ray on the current axis
%
%   drawRay(RAY)
%   With RAY having the syntax: [x0 y0 dx dy], draws the ray starting from
%   point (x0 y0) and going to direction (dx dy), clipped with the current
%   window axis.
%
%   drawRay(RAY, PARAMS, VALUE)
%   Can specify param-pair values.
%
%   H = drawRay(...)
%   Returns handle on line object
%
%   See also:
%   rays2d, drawLine
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY :
%   2005/07/06: add support for multiple rays
%   2007/10/18: add support for drawing options


% get bounding box limits
lim = get(gca, 'xlim');
xmin = lim(1);
xmax = lim(2);
lim = get(gca, 'ylim');
ymin = lim(1);
ymax = lim(2);

% allocate memory for handle
h = zeros(size(ray, 1), 1);

for i=1:size(ray, 1)    
    % intersection with axis : x=xmin
    px1 = intersectLines(ray(i, 1:4), [xmin ymin 0 1]);
    px2 = intersectLines(ray(i, 1:4), [xmax ymin 0 1]);
    py1 = intersectLines(ray(i, 1:4), [xmin ymin 1 0]);
    py2 = intersectLines(ray(i, 1:4), [xmin ymax 1 0]);

    % sort points along the x coordinate, and  draw a line between
    % the two in the middle
    points = sortrows([px1 ; px2 ; py1 ; py2], 1);

    if points(2,1)>=xmin && points(2,1)<=xmax
        if isfinite(points(3,1))
            % case of non-vertical lines
            if isPointOnRay(points(2,:), ray(i,1:4))
                if isPointOnRay(points(3,:), ray(i,1:4))
                    h(i)=line(points(2:3, 1), points(2:3, 2));
                else
                    h(i)=line([points(2,1) ray(i,1)], [points(2,2) ray(i,2)]);
                end
            else
                if isPointOnRay(points(3,:), ray(i,:))
                    h(i)=line([points(3, 1) ray(i,1)], [points(3,2) ray(i,2)]);
                else
                    h(i)=-1;
                end
            end
        else
            % special case of vertical lines : only 2 intersections max
            if isPointOnRay(points(1,:), ray(i,1:4))
                if onRay(points(2,:), ray(i,1:4))
                    h(i)=line(points(1:2, 1), points(1:2, 2));
                else
                    h(i)=line([points(1,1) ray(i,1)], [points(1,2) ray(i,2)]);
                end
            else
                if isPointOnRay(points(2,:), ray(i,1:4))
                    h(i)=line([points(2, 1) ray(i,1)], [points(2,2) ray(i,2)]);
                else
                    h(i)=-1;
                end
            end
        end
    else
        h(i)=-1;
    end
end

if ~isempty(varargin)
    set(h(h>0), varargin{:});
end

if nargout>0
    varargout{1}=h;
end