function edge = createEdge(varargin)
%CREATEEDGE Create an edge between two points, or from a line.
%
%   The internal format for edge representation is given by coordinates of
%   two points : [x1 y1 x2 y2].
%   This function can serve as a line to edge converter.
%
%
%   E = createEdge(P1, P2);
%   Returns the edge between the two given points P1 and P2.
%   
%   E = createEdge(x0, y0, dx, dy);
%   Returns the edge going through point (x0, y0) and with direction
%   vector (dx,dy).
%
%   E = createEdge(param);
%   where param is an array of 4 values, creates the edge going through the
%   point (param(1) param(2)), and with direction vector given by
%   (param(3) param(4)).
%   
%   E = createEdge(LINE, D);
%   create the edge contained in LINE, with same direction and start point,
%   but with length given by D.
%
%
%   Note: in all cases, parameters can be vertical arrays of the same
%   dimension. The result is then an array of edges, of dimensions N-by-4.
%
%
%   See also 
%   edges2d, lines2d, drawEdge, clipEdge, createLine
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-10-31
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

if nargin == 1
    % Only one input parameter. It can be :
    % - line angle
    % - array of four parameters
    % TODO : add control for arrays of lines.
    var = varargin{1};
    
    if size(var, 2)==4
        % 4 parameters of the line in a single array.
        %edge = var;
        edge = zeros(size(var));
        edge(:, 1:2) = var(:,1:2);
        edge(:, 3:4) = edge(:, 1:2)+var(:,3:4);
    elseif size(var, 2)==1
        % 1 parameter : angle of the line, going through origin.
        edge = [zeros(size(var,1)) zeros(size(var,1)) cos(var) sin(var)];
    else
        error('wrong number of dimension for arg1 : can be 1 or 4');
    end
    
elseif nargin == 2    
    % 2 input parameters. They can be :
    % - 2 points, then 2 arrays of 1*2 double,
    % - a line, and a distance.
    
    % extract the two arguments
    v1 = varargin{1};
    v2 = varargin{2};
    
    if size(v1, 2) == 2
        % first input parameter is first point, and second input is the
        % second point.
        %edge = [v1(:,1), v1(:,2), v2(:,1), v2(:,2)];
        edge = [v1 v2];
    else
        % first input parameter is a line, and second one a distance.
        angle = atan2(v1(:,4), v1(:,3));
        edge = [v1(:,1), v1(:,2), v1(:,1)+v2.*cos(angle), v1(:,2)+v2.*sin(angle)];
    end
    
elseif nargin == 3
    % 3 input parameters :
    % first one is a point belonging to the line,
    % second and third ones are direction vector of the line (dx and dy).
    p = varargin{1};
    edge = [p(:,1) p(:,2) p(:,1)+varargin{2} p(:,2)+varargin{3}];
   
elseif nargin == 4
    % 4 input parameters :
    % they are x0, y0 (point belonging to line) and dx, dy (direction
    % vector of the line).
    % All parameters should have the same size.
    edge = [varargin{1} varargin{2} varargin{1}+varargin{3} varargin{2}+varargin{4}];
else
    error('Wrong number of arguments in ''createEdge'' ');
end
