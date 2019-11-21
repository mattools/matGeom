function demoDrawPoint3d
%DEMODRAWPOINT3D Demo of drawPoint3d
%
%   Example
%     demoDrawPoint3d
%
%   See also
%

% ------
% Author: oqilipo
% Created: 2018-01-12, using R2017b
% Copyright 2018

%% Initialisation
ptsx = rand(1,5);
ptsy = rand(1,5);
ptsz = rand(1,5);

pts2 = rand(5,3);

%% 1
figure('color','w');
drawPoint3d(ptsx, ptsy, ptsz)
hold on
drawPoint3d(gca,pts2)
%% 2
figure('color','w')
drawPoint3d(pts2,'g.')
hold on
drawPoint3d(gca,ptsx, ptsy, ptsz,'r')
%% 3
figure('color','w')
props.Marker='o';
props.MarkerEdgeColor='r';
props.MarkerFaceColor='g';
props.LineStyle='none';
drawPoint3d(ptsx, ptsy, ptsz,props,'MarkerSize',12)
hold on
drawPoint3d(gca,pts2,props,'MarkerSize',5)
%% 4
figure('color','w')
drawPoint3d(ptsx, ptsy, ptsz,'MarkerSize',8,props,'Marker','s')
hold on
drawPoint3d(gca, pts2,'MarkerSize',12,props,'Marker','h')
%% 5
figure('color','w')
drawPoint3d(ptsx, ptsy, ptsz,props)
hold on
drawPoint3d(gca,pts2,props)