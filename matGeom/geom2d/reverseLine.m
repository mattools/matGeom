function line = reverseLine(line)
%REVERSELINE Return same line but with opposite orientation
%
%   INVLINE = reverseLine(LINE);
%   Returns the opposite line of LINE.
%   LINE has the format [x0 y0 dx dy], then INVLINE will have following
%   parameters: [x0 y0 -dx -dy].
%
%   See also:
%   lines2d, createLine
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 20/01/2004.
%

%   HISTORY
%   30/06/2009 rename as reverseLine
%   15/03/2011 simplify code

line(:, 3:4) = -line(:, 3:4);

    