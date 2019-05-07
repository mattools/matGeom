%drawCrackPattern : dessine un motif de fissures
%
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 15/08/2005.


%% Initialisations

% clean up
clear all;
close all;

% size of window
window = [0 100 0 100];

% box as polygon
box = [0 0;100 0;100 100;0 100];

% points density
lambda = .005;


%% compute diagram

% number of points
Np = round((window(2)-window(1))*(window(4)-window(3)) * lambda);

% points coordinate
x = rand(Np, 1)*(window(2)-window(1)) + window(1);
y = rand(Np, 1)*(window(4)-window(3)) + window(3);
points = [x y];

% random angles 
angles = rand(Np, 1)*pi;
angles = mod([angles angles+2*pi/3 angles+4*pi/3], 2*pi);

% compute crack pattern
edges = crackPattern2(box, points, angles);


%% Draw Result

% create figure
figure(1); clf;
axis(window);hold on;

% draw diagram
drawEdge(edges);
drawPoint(points, 'bo');

% clean up window
set(gca, 'box', 'on');
set(gca, 'xtick', []);
set(gca, 'ytick', []);


