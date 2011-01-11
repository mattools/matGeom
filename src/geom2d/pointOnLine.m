function point = pointOnLine(line, d)
%POINTONLINE create a point on a line at a given distance from line origin
%
%   P = pointOnLine(LINE, D);
%   Creates the point belonging to the line LINE, and located at the
%   distance D from the line origin.
%   LINE has the form [x0 y0 dx dy].
%   LINE and D should have the same number N of rows. The result will have
%   N rows ans 2 column (x and y positions).
%
%   See also:
%   lines2d, points2d, onLine, onLine, linePosition
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 07/04/2004.
%


angle = lineAngle(line);
point = [line(:,1)+d.*cos(angle), line(:,2)+d.*sin(angle)];
    