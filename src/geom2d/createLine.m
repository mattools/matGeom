function line = createLine(varargin)
%CREATELINE Create a straight line from 2 points, or from other inputs
%
%   Line is represented in a parametric form : [x0 y0 dx dy]
%   x = x0 + t*dx
%   y = y0 + t*dy;
%
%
%   L = createLine(p1, p2);
%   Returns the line going through the two given points.
%   
%   L = createLine(x0, y0, dx, dy);
%   Returns the line going through point (x0, y0) and with direction
%   vector(dx, dy).
%
%   L = createLine(LINE);
%   where LINE is an array of 4 values, creates the line going through the
%   point (LINE(1) LINE(2)), and with direction given by vector (LINE(3)
%   LINE(4)). 
%   
%   L = createLine(THETA);
%   Create a polar line originated at (0,0) and with angle THETA.
%
%   L = createLine(RHO, THETA);
%   Create a polar line with normal theta, and with min distance to origin
%   equal to rho. rho can be negative, in this case, the line is the same
%   as with CREATELINE(-rho, theta+pi), but the orientation is different.
%
%
%   Note: in all cases, parameters can be vertical arrays of the same
%   dimension. The result is then an array of lines, of dimensions [N*4].
%
%
%   See also:
%   lines2d, createEdge, createRay
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY :
%   18/02/2004 : add more possibilities to create lines (4 parameters,
%      all param in a single tab, and point + dx + dy.
%      Also add support for creation of arrays of lines.

%   NOTE : A line can also be represented with a 1*5 array : 
%   [x0 y0 dx dy t].
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
%   This seems us a convenient way to represent uniformly all kind of lines
%   (including edges, rays, and even point).
%

%   NOTE2 : Any line object can be represented using a 1x6 array :
%   [x0 y0 dx dy t0 t1]
%   the first 4 parameters define the supporting line,
%   t0 represent the position of the first point on the line, 
%   and t1 the position of the last point.
%   * for edges : t0 = 0, and t1=1
%   * for straight lines : t0 = -inf, t1=inf
%   * for rays : t0=0, t1=inf (or t0=-inf,t1=0 for inverted ray).
%   I propose to call these objects 'lineArc'

if length(varargin)==1
    % Only one input parameter. It can be :
    % - line angle
    % - array of four parameters
    % TODO : add control for arrays of lines.
    var = varargin{1};
    
    if size(var, 2)==4
        % 4 parameters of the line in a single array.
        line = var;
    elseif size(var, 2)==1
        % 1 parameter : angle of the line, going through origin.
        line = [zeros(size(var)) zeros(size(var)) cos(var) sin(var)];
    else
        error('wrong number of dimension for arg1 : can be 1 or 4');
    end
    
elseif length(varargin)==2    
    % 2 input parameters. They can be :
    % - line angle and signed distance to origin.
    % - 2 points, then 2 arrays of 1*2 double.
    v1 = varargin{1};
    v2 = varargin{2};
    if size(v1, 2)==1
        % first param is angle of line, and second param is signed distance
        % to origin.
        line = [v1.*cos(v2) v1.*sin(v2) -sin(v2) cos(v2)];
    else
        % first input parameter is first point, and second input is the
        % second point.
        line = [v1(:,1), v1(:,2), v2(:,1)-v1(:,1), v2(:,2)-v1(:,2)];    
    end
    
elseif length(varargin)==3
    % 3 input parameters :
    % first one is a point belonging to the line,
    % second and third ones are direction vector of the line (dx and dy).
    p = varargin{1};
    line = [p(:,1) p(:,2) varargin{2} varargin{3}];
   
elseif length(varargin)==4
    % 4 input parameters :
    % they are x0, y0 (point belongng to line) and dx, dy (direction vector
    % of the line).
    % All parameters should have the same size.
    line = [varargin{1} varargin{2} varargin{3} varargin{4}];
else
    error('Wrong number of arguments in ''createLine'' ');
end
