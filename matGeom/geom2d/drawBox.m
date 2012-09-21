function varargout = drawBox(box, varargin)
%DRAWBOX Draw a box defined by coordinate extents
%   
%   drawBox(BOX)
%   Draws a box defined by its extent: BOX = [XMIN XMAX YMIN YMAX].
%
%   drawBox(..., NAME, VALUE)
%   Specifies drawing parameters using parameter name and value. See plot
%   function for syntax.
%
%   drawBox(AX, ...)
%   Specifies the handle of the axis to draw on.
%
%   Example
%     % define some points, compute their box, display everything
%     points = [10 30; 20 50; 20 20; 30 10;40 30;50 20];
%     box = pointSetBounds(points);
%     figure; hold on;
%     drawPoint(points, 's');
%     drawBox(box);
%     axis([0 60 0 60]);
%
%   See Also:
%   drawOrientedBox, drawRect
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/12/2003.
%

%   HISTORY
%   2010-02-22 creation
%   2011-04-01 add support for drawing option, fix bug for several boxes
%   2011-10-11 add management of axes handle

% extract handle of axis to draw on
if isAxisHandle(box)
    ax = box;
    box = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% default values
xmin = box(:,1);
xmax = box(:,2);
ymin = box(:,3);
ymax = box(:,4);

nBoxes = size(box, 1);
r = zeros(nBoxes, 1);

% iterate on boxes
for i = 1:nBoxes
    % exract min and max values
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

    % display polygon
    r(i) = plot(ax, tx, ty, varargin{:});
end

% format output
if nargout > 0
    varargout = {r};
end
