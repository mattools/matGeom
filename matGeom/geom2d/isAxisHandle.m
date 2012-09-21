function b = isAxisHandle(arg)
%ISAXISHANDLE Check if the input corresponds to a valid axis hanfle
%
%   B = isAxisHandle(VAR)
%   If the value of VAR is scalar, corresponds to a valid matlab handle,
%   and has type equal to 'axis', then returns TRUE. Otherwise, returns
%   false.
%   This function is used to check if first argument of drawing functions
%   corresponds to data or to axis handle to draw in.
%
%   Example
%     isAxisHandle(gca)
%     ans =
%         1
%
%   See also
%   drawPoint, drawLine, drawEdge
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-09-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

b = isscalar(arg) && ishandle(arg) && strcmp(get(arg, 'type'), 'axes');