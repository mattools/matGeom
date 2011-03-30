function line = createLine3d(varargin)
%CREATELINE3D Create a line with various inputs.
%
%   Line is represented in a parametric form : [x0 y0 z0 dx dy dz]
%       x = x0 + t*dx
%       y = y0 + t*dy;
%       z = z0 + t*dz;
%
%
%   L = createLine3d(P1, P2);
%   Returns the line going through the two given points P1 and P2.
%   
%   L = createLine3d(X0, Y0, Z0, DX, DY, DZ);
%   Returns the line going through the point [x0, y0, z0], and with
%   direction vector given by [DX DY DZ]. 
%
%   L = createLine3d(P0, DX, DY, DZ);
%   Returns the line going through point P0 given by [x0, y0, z0] and with
%   direction vector given by [DX DY DZ]. 
%
%   L = createLine3d(THETA, PHI);
%   Create a line originated at (0,0) and with angles theta and phi.
%
%   L = createLine3d(P0, THETA, PHI);
%   Create a line with direction given by theta and phi, and which contains
%   point P0. 
%
%
%   Note : in all cases, parameters can be vertical arrays of the same
%   dimension. The result is then an array of lines, of dimensions [N*6].
%
%   See also:
%   lines3d
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005.
%

%   HISTORY
%   30/11/2005 add more cases
%   04/01/2007 remove unused variables

%   NOTE : A 3d line can also be represented with a 1*7 array : 
%   [x0 y0 z0 dx dy dz t].
%   whith 't' being one of the following : 
%   - t=0 : line is a singleton (x0,y0)
%   - t=1 : line is an edge segment, between points (x0,y0) and (x0+dx,
%   y0+dy).
%   - t=Inf : line is a Ray, originated from (x0,y0) and going to infinity
%   in the direction(dx,dy).
%   - t=-Inf : line is a Ray, originated from (x0,y0) and going to infinity
%   in the direction(-dx,-dy).
%   - t=NaN : line is a real straight line, and contains all points
%   verifying the above equation.
%   This seems to be a convenient way to represent uniformly all kind of
%   lines (including edges, rays, and even point).
%
%   NOTE2 : Another form is the 1*8 array :
%   [x0 y0 z0 dx dy dz t1 t2].
%   with t1 and t2 giving first and last position of the edge on the
%   supporting straight line, and with t2>t1.

if length(varargin)==1    
    error('Wrong number of arguments in ''createLine'' ');
    
elseif length(varargin)==2    
    % 2 input parameters. They can be :
    % - 2 points, then 2 arrays of 1*2 double.
    v1 = varargin{1};
    v2 = varargin{2};
    if size(v1, 2)==3
        % first input parameter is first point, and second input is the
        % second point.
        line = [v1(:,1) v1(:,2) v1(:,3) v2(:,1)-v1(:,1) v2(:,2)-v1(:,2) v2(:,3)-v1(:,3)];    
    elseif size(v1, 2)==1
        % first parameter is angle with the vertical
        % second parameter is horizontal angle with Ox axis
        theta = varargin{1};
        phi = varargin{2};

        sit = sin(theta);
        p0 = zeros([size(theta, 1) 3]);
        
        line = [p0 cos(phi)*sit sin(phi)*sit cos(theta)];
    end
    
elseif length(varargin)==3
    % 3 input parameters :
    % first parameter is a point of the line
    % second parameter is angle with the vertical
    % third parameter is horizontal angle with Ox axis
    p0      = varargin{1};
    theta   = varargin{2}; 
    phi     = varargin{3};
    
    if size(p0, 2)~=3
        error('first argument should be a 3D point');
    end
    
    sit = sin(theta);
    line = [p0 cos(phi)*sit sin(phi)*sit cos(theta)];
    
elseif length(varargin)==4
    % 4 input parameters :
    p0 = varargin{1};
    dx = varargin{2};
    dy = varargin{3};
    dz = varargin{4};
    
    if size(p0, 2)~=3
        error('first argument should be a 3D point');
    end
    
    line = [p0 dx dy dz];
elseif length(varargin)==5
    % 5 input parameters :
    % first parameter is distance of lin to origin
    % second parameter is angle with the vertical
    % third parameter is horizontal angle with Ox axis
    x0      = varargin{1};
    y0      = varargin{1};
    z0      = varargin{1};
    theta   = varargin{2}; 
    phi     = varargin{3};
    
    sit = sin(theta);
    line = [x0 y0 z0 cos(phi)*sit sin(phi)*sit cos(theta)];

elseif length(varargin)==6
    % 6 input parameters, given as separate arguments for x0, y0, z0 and 
    % dx, dy and dz
    % (not very useful, but anyway...)
    x0 = varargin{1};
    y0 = varargin{2};
    z0 = varargin{3};
    dx = varargin{4};
    dy = varargin{5};
    dz = varargin{6};

    line = [x0 y0 z0 dx dy dz];
end
