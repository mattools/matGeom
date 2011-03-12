%% Draw Poisson lines
%
%   Draw Poisson lines, that is lines uniformly and isotropically
%   distributed in the plane.
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 24/06/2005
%


%% initializations

% clean up
clear all;
close all;

% line density
lambdaRho = .5;

% maximal distance of lines from origin
rhoMax = 150;

% number of lines
Nl = rhoMax*lambdaRho;

%% create lines

% use uniform distribution for \theta, and linear for \rho
theta = 2*pi*rand(Nl, 1);
rho   = rhoMax*rand(Nl, 1);

% convert to parametric representation
lines = createLine(rho, theta);


%% draw lines

% format output window
clf;
axis([-100 100 -100 100]);
hold on;

% draw Lines, automatically clipped
drawLine(lines);

% title
title(sprintf('poisson lines, with density %f', lambdaRho));

%% Also draw intersection points

% detect intersections
pts = zeros(0, 2);
for i=1:size(lines, 1)-1
    pts = [pts ; intersectLines(lines(i,:), lines(i+1:end, :))];
end

% remove cases with parallel cases (should not appear, but ...)
pts = pts(isfinite(pts(:,1)), :);

% draw points on image
hold on;
drawPoint(pts, 'ro');


