function [dist, proj] = distancePointEllipse(point, elli)
%DISTANCEPOINTELLIPSE Distance from a point to an ellipse.
%
%   DIST = distancePointEllipse(POINT, ELLI)
%   Computes the Euclidean distance between the point POINT and the ellipse
%   ELLI.
%   POINT may also be a N-by-2 array of point coordinates. In that case the
%   result is a N-by-1 array of distances.
%
%   [DIST, PROJ] = distancePointEllipse(POINT, ELLI)
%   Also return the coordinates of the projection of the point onto the
%   ellipse. PROJ has same dimensions as the array POINT.
%
%   Example
%     % create an ellipse
%     elli = [50 50 40 30 20];
%     % generate points along a regular grid
%     [x, y] = meshgrid(1:100, 1:100);
%     pts = [x(:) y(:)];
%     % compute distance map
%     distMap = reshape(distancePointEllipse(pts, elli), size(x));
%     figure; imshow(distMap, []); colormap parula;
%
%
%   References:
%     https://blog.chatfield.io/simple-method-for-distance-to-ellipse/
%
%   See also 
%     ellipses2d, projPointOnEllipse, distancePoints
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2022-07-17, using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE - BIA Research Unit - BIBS Platform (Nantes)

proj = projPointOnEllipse(point, elli);

dist = distancePoints(point, proj, 'diag');
