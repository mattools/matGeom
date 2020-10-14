function demoProjPointOnCircle3d
%DEMOPROJPOINTONCIRCLE3D demo for projPointOnCircle3d
%
%   Example
%     demoProjPointOnCircle3d
%
%   See also
%

% ------
% Author: oqilipo
% Created: 2020-10-12, using R2019b
% Copyright 2020

% Create random circle
circle = [-50+100*rand(1,3) randi([20 50]) 180*rand 360*rand 360*rand];

% Create some random points
points = -100+200*rand(5,3);

points2 = projPointOnCircle3d(points, circle);

figure('color','w')
axis([-100 100 -100 100 -100 100]);
hold on
drawPoint3d(points,'r.')
drawCircle3d(circle,'g')
drawPoint3d(circle(1:3),'g.')
drawPoint3d(points2,'b.')

end