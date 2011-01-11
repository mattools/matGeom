function drawBox3d(box, varargin)
%DRAWBOX3D Draw a 3D box defined by coordinate extents
%   
%   drawBox3d(BOX);
%   Draw a box defined by its coordinate extents: 
%   BOX = [XMIN XMAX YMIN YMAX ZMIN ZMAX].
%   The function draws only the outline edges of the box.
%
%   See Also:
%   boxes3d, drawRect2, drawRect
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
zmin = box(:,5);
zmax = box(:,6);

nBoxes = size(box, 1);

for i=1:length(nBoxes)
    % lower face (z=zmin)
    drawEdge3d([xmin(i) ymin(i) zmin(i)     xmax(i) ymin(i) zmin(i)], varargin{:});
    drawEdge3d([xmin(i) ymin(i) zmin(i)     xmin(i) ymax(i) zmin(i)], varargin{:});
    drawEdge3d([xmax(i) ymin(i) zmin(i)     xmax(i) ymax(i) zmin(i)], varargin{:});
    drawEdge3d([xmin(i) ymax(i) zmin(i)     xmax(i) ymax(i) zmin(i)], varargin{:});
 
    % front face (y=ymin)
    drawEdge3d([xmin(i) ymin(i) zmin(i)     xmin(i) ymin(i) zmax(i)], varargin{:});
    drawEdge3d([xmax(i) ymin(i) zmin(i)     xmax(i) ymin(i) zmax(i)], varargin{:});
    drawEdge3d([xmin(i) ymin(i) zmax(i)     xmax(i) ymin(i) zmax(i)], varargin{:});

    % left face (x=xmin)
    drawEdge3d([xmin(i) ymax(i) zmin(i)     xmin(i) ymax(i) zmax(i)], varargin{:});
    drawEdge3d([xmin(i) ymin(i) zmax(i)     xmin(i) ymax(i) zmax(i)], varargin{:});

    % the last 3 remaining edges
    drawEdge3d([xmin(i) ymax(i) zmax(i)     xmax(i) ymax(i) zmax(i)], varargin{:});
    drawEdge3d([xmax(i) ymax(i) zmin(i)     xmax(i) ymax(i) zmax(i)], varargin{:});
    drawEdge3d([xmax(i) ymin(i) zmax(i)     xmax(i) ymax(i) zmax(i)], varargin{:});

end
