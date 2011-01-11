function res = orthogonalLine(line, point)
%ORTHOGONALLINE Create a line orthogonal to another one.
%
%   PERP = orthogonalLine(LINE, POINT);
%   Returns the line orthogonal to the line LINE and going through the
%   point given by POINT. Directed angle from LINE to PERP is pi/2.
%   LINE is given as [x0 y0 dx dy] and POINT is [xp yp].
%
%   See also:
%   lines2d, parallelLine
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   19/02/2004 added control for multiple lines and/or points


N = max(size(point, 1), size(line, 1));

if size(point, 1)>1
    res = point;
else
    res = ones(N, 1)*point;
end

if size(line, 1)>1
    res(:,3) = -line(:,4);
    res(:,4) = line(:,3);
else
    res(:,3) = -ones(N,1)*line(4);
    res(:,4) = ones(N,1)*line(3);
end

