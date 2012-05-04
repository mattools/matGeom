function [hd ind1 ind2] = hausdorffDistance(pts1, pts2)
%HAUSDORFFDISTANCE  Hausdorff distance between two point sets
%
%   HD = hausdorffDistance(PTS1, PTS2)
%   Computes the Hausdorff distance between the two point sets PTS1 and
%   PTS2. The Hausdorf distance can be used to compare two shapes. 
%
%   The distance between a point x and a set Y is given by:
%     d(x, Y) = inf { d(x,y) | y in Y }
%   The distance between two non empty sets X and Y is given by:
%     d(X, Y) = sup { d(x,Y) | x in X }
%   The Hausdorff distance between sets X and Y distance is defined as the
%   maximum of d(X,Y) and d(Y,X):
%     HD(X,Y) = max { d(X,Y), d(Y,X) }
%
%
%   Example
%   % Compute Hausdorff distance between an ellipse and a rectangle
%     % first define two shapes
%     rect = resamplePolygon(orientedBoxToPolygon([20 30 80 40 30]), 60);
%     poly = ellipseToPolygon([20 30 40 20 30], 500);
%     % display the shapes
%     figure; hold on
%     drawPolygon(poly, 'b');
%     drawPolygon(rect, 'g');
%     axis equal;
%     % compute hausdorff distance
%     [hd ind1 ind2] = hausdorffDistance(poly, rect);
%     p1h = poly(ind1, :);
%     p2h = rect(ind2, :);
%     drawPoint([p1h;p2h], 'mo');
%     drawEdge([p1h p2h], 'm')
%
%   See also
%   minDistancePoints
%
%   References
%   http://en.wikipedia.org/wiki/Hausdorff_distance
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-05-04,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

% distance from pts1 to pts2
[dists1 ind12] = minDistancePoints(pts1, pts2);
[max1 ind11] = max(dists1);

% distance from pts2 to pts1
[dists2 ind22] = minDistancePoints(pts2, pts1);
[max2 ind21] = max(dists2);

% keep the max of the two distances
hd = max(max1, max2);

% keep the rigt indices
if max1 > max2
    ind1 = ind11;
    ind2 = ind12(ind11);
else
    ind1 = ind22(ind21);
    ind2 = ind21;
end
