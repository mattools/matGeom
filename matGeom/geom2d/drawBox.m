function varargout = drawBox(box, varargin)
%DRAWBOX Draw a box defined by coordinate extents
%   
%   drawBox(BOX)
%   Draw a box defined by extent: BOX = [XMIN XMAX YMIN YMAX].
%
%
%   See Also:
%   drawRect2, drawRect
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/12/2003.
%

%   HISTORY
%   2010-02-22 creation
%   2011-04-01 add support for drawing option, fix bug for several boxes

% default values
xmin = box(:,1);
xmax = box(:,2);
ymin = box(:,3);
ymax = box(:,4);

nBoxes = size(box, 1);
r = zeros(nBoxes, 1);

for i = 1:nBoxes
    tx(1) = xmin(i);
    ty(1) = ymin(i);
    tx(2) = xmax(i);
    ty(2) = ymin(i);
    tx(3) = xmax(i);
    ty(3) = ymax(i);
    tx(4) = xmin(i);
    ty(4) = ymax(i);
    tx(5) = xmin(i);
    ty(5) = ymin(i);

    r(i) = plot(tx, ty, varargin{:});
end

if nargout > 0
    varargout = {r};
end
