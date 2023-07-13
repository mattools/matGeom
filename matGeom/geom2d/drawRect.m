function varargout = drawRect(rect, varargin)
%DRAWRECT Draw rectangle on the current axis.
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
%   drawRect(AX, ...) 
%   Specifies the handle of the axis to draw the rectangle on.
%
%   H = drawRect(...) 
%   Returns handle of the created graphic objects.
%
%   See also 
%     drawOrientedBox, drawBox, rectToPolygon
%

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2003-12-10
% Copyright 2003-2023 INRA - TPV URPOI - BIA IMASTE

% extract handle of axis to draw on
if isAxisHandle(rect)
    ax = rect;
    rect = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% number of rectangles to draw
n = size(rect, 1);

% display each rectangle
r = zeros(n, 1);
for i = 1:n
    % compute vertex corodinates
    poly = rectToPolygon(rect(i, :));
    % display resulting polygon
    r(i) = drawPolygon(ax, poly, varargin{:});
end

% process output
if nargout > 0
    varargout = {r};
end
