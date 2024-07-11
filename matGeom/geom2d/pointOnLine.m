function point = pointOnLine(line, pos)
%POINTONLINE Create a point on a line at a given position on the line.
%
%   P = pointOnLine(LINE, POS);
%   Creates the point belonging to the line LINE, and located at the
%   distance D from the line origin.
%   LINE has the form [x0 y0 dx dy].
%   LINE and D should have the same number N of rows. The result will have
%   N rows ans 2 column (x and y positions).
%
%   See also 
%     linePoint, linePosition

% ------
% Author: David Legland 
% E-mail: david.legland@inrae.fr
% Created: 2004-04-07
% Copyright 2004-2024 INRA - TPV URPOI - BIA IMASTE

% deprecation warning
warning('geom2d:deprecated', ...
    '''pointOnLine'' is deprecated, use ''linePoint'' instead');

angle = lineAngle(line);
point = [line(:,1) + pos .* cos(angle), line(:,2) + pos .* sin(angle)];
    
