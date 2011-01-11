function varargout = drawBox(box)
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

% HISTORY
% 2010-02-22 creation


% default values

xmin = box(:,1);
xmax = box(:,2);
ymin = box(:,3);
ymax = box(:,4);

nBoxes = size(box, 1);
r = zeros(nBoxes, 1);

for i=1:length(nBoxes)
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

    r(i) = line(tx, ty);
end

if nargout>0
    varargout{1}=r;
end