% Demo script on various ways to create an ellipse.
%
%   output = create_ellipse_demo(input)
%
%   Example
%   create_ellipse_demo
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-09-09,    using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE.


%% Use explicit representation

center = [50 50];
radii = [40 20];
theta = 30;
elli0 = [center radii theta];

figure; hold on; axis square; axis([0 100 0 100]);
drawEllipse(elli0, 'lineWidth', 2, 'color', 'b');


%% Fit an ellipse to a set of points

% choose several points on the ellipse, and add some noise
nPoints = 100;
ti = rand(nPoints, 1) * 2 * pi;
pts = ellipsePoint(elli0, ti) + randn(nPoints, 2) * 2;

% fit the ellipse to the set of points
elli = fitEllipse(pts);

% display points and fit result
figure; hold on; axis square; axis([0 100 0 100]);
drawPoint(pts, 'linewidth', 1, 'color', 'b');
drawEllipse(elli, 'lineWidth', 2, 'color', 'm');


%% Equivalent ellipse from a set of points

% generate random points within the ellipse, 
% with a density equal to 1 (1 point per unit square on average)
nPoints = round(ellipseArea(elli));
pts0 = zeros(nPoints, 2);
for iPoint = 1:nPoints
    while true
        pt = rand([1 2]) * 100;
        if isPointInEllipse(pt, elli0)
            pts(iPoint,:) = pt;
            break;
        end
    end
end

% computes equivalent ellipse
elli = equivalentEllipse(pts);

% display result
figure; hold on; axis square; axis([0 100 0 100]);
drawPoint(pts, 'b.');
drawEllipse(elli, 'lineWidth', 2, 'color', 'm');
drawEllipseAxes(elli, 'lineWidth', 2, 'color', 'm');
