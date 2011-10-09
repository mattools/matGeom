function varargout = drawRect(rect, varargin)
%DRAWRECT Draw rectangle on the current axis
%   
%   drawRect(RECT)
%   draws the rectangles defined by RECT = [X0 Y0 W H].
%   the four corners of rectangle are then :
%   (X0, Y0), (X0+W, Y0), (X0, Y0+H), (X0+W, Y0+H).
%
%   RECT = [X0 Y0 W H THETA] also specifies orientation for the rectangle.
%   Theta is given in degrees.
%
%   If RECT is a N-by-4 or N-by-5 array, several rectangles are drawn.
%
%   drawRect(..., PARAM, VALUE)
%   Specifies one or several parameters name-value pairs, see plot function
%   for details.
%
%   H = drawRect(...) 
%   Returns handle of the created graphic objects.
%
%   See Also:
%   drawOrientedBox, drawBox, rectToPolygon
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/12/2003.
%

%   HISTORY
%   2003-12-12 add support for multiple rectangles
%   2011-10-09 rewrite using rectToPolygon, add support for drawing options

n = size(rect, 1);

r = zeros(n, 1);
for i = 1:n
    poly = rectToPolygon(rect(i, :));
    r(i) = drawPolygon(poly, varargin{:});
end

if nargout > 0
    varargout = {r};
end
