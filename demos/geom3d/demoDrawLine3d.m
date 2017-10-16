%DEMODRAWLINE3D demo for drawLine3d
%
%   Example
%   demodrawLine3d
%
%   See also
%
% ------
% Author: oqilipo
% Created: 2017-10-13, using R2017b
% Copyright 2017

p0 = [1 2 3];
v1 = [1 0 1];
v2 = [0 -1 1];
line1 = [p0 v1];
lines=[v1 p0;v1 v2];

%% 1
figure('color','w')
axis([-10 10 -10 10 -10 10]);
drawLine3d(line1)
drawLine3d(gca,lines)
%% 2
figure('color','w')
axis([-10 10 -10 10 -10 10]);
drawLine3d(line1,'r')
drawLine3d(gca,lines,[1 0 0])
%% 3
figure('color','w')
axis([-10 10 -10 10 -10 10]);
props.Marker='o';
props.MarkerFaceColor='g';
props.MarkerEdgeColor='b';
drawLine3d(line1,props,'Color','m')
drawLine3d(gca,lines,props,'Color','m')
%% 4
figure('color','w')
axis([-10 10 -10 10 -10 10]);
drawLine3d(line1,'LineWidth',2,props,'LineStyle','-.')
drawLine3d(gca, lines,'LineWidth',2,props,'LineStyle','-.')
%% 5
figure('color','w')
axis([-10 10 -10 10 -10 10]);
drawLine3d(gca,line1,props)
drawLine3d(gca,lines,props)

