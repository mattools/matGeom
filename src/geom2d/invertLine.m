function line = invertLine(var)
%INVERTLINE return same line but with opposite orientation
%
%   INVLINE = invertLine(LINE);
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
%   30/06/2009 deprecate and replace by 'reverseLine'.

% deprecation warning
warning('geom2d:deprecated', ...
    '''invertLine'' is deprecated, use ''reverseLine'' instead');

line = 0;    

if size(var, 1)==1
    % only one line in a single array
    line = [var(1) var(2) -var(3) -var(4)];
else
    % several lines in a single array
    n = size(var, 1);
    line(1:n, 1) = var(1:n, 1);
    line(1:n, 2) = var(1:n, 2);
    line(1:n, 3) = -var(1:n, 3);
    line(1:n, 4) = -var(1:n, 4);
end
