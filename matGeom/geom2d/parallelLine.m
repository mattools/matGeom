function res = parallelLine(line, point)
%PARALLELLINE Create a line parallel to another one.
%
%   RES = parallelLine(LINE, POINT);
%   Returns the line with same direction vector than LINE and going through
%   the point given by POINT. 
%   LINE is given as [x0 y0 dx dy] and POINT is [xp yp].
%
%
%   RES = parallelLine(LINE, DIST);
%   Uses relative distance to specify position. The new line will be
%   located at distance DIST, counted positive in the right side of LINE
%   and negative in the left side.
%
%   Examples
%     P1 = [20 30]; P2 = [50 10];
%     L1 = createLine([50 10], [20 30]);
%     figure; hold on; axis equal; axis([0 60 0 50]);
%     drawPoint([P1; P2], 'ko');
%     drawLine(L1, 'k');
%     P = [30 40];
%     drawPoint(P, 'ko');
%     L2 = parallelLine(L1, P);
%     drawLine(L2, 'Color', 'b');
%
%   See also:
%   lines2d, orthogonalLine, distancePointLine, parallelEdge
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 31/10/2003.
%

%   HISTORY
%   31/07/2005 add usage of distance
%   15/06/2009 change convention for distance sign
%   31/09/2012 adapt for multiple lines

if size(point, 2) == 1
    % use a distance. Compute position of point located at distance DIST on
    % the line orthogonal to the first one.
    point = pointOnLine([line(:,1) line(:,2) line(:,4) -line(:,3)], point);
end

% normal case: compute line through a point with given direction
res = zeros(size(line, 1), 4);
res(:, 1:2) = point;
res(:, 3:4) = line(:, 3:4);
