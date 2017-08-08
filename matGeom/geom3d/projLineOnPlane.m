function [newLine, isOrthogonal] = projLineOnPlane(line, plane)
%PROJLINEONPLANE Return the orthogonal projection of a line on a plane
% 
%   NEWLINE = PROJLINEONPLANE(LINE, PLANE) Returns the orthogonal
%   projection of LINE or multiple lines on the PLANE.
%
%   [..., ISORTHOGONAL] = PROJLINEONPLANE(LINE, PLANE) Also returns if the
%   LINE is orthogonal to the PLANE.
%
%   Example
%     plane = [.1 .2 .3 .4 .5 .6 .7 .8 .9];
%     lines = [0 .3 0 1 0 0;0  .5 .5 0 0 1;...
%         .4 .1 .5 1 0 2;.2 .7 .1 0 1 0;...
%         plane(1:3) planeNormal(plane)];
%     [newLines, isOrthogonal] = projLineOnPlane(lines, plane);
%     figure('color','w'); axis equal; view(3)
%     drawLine3d(lines,'b')
%     drawPlane3d(plane)
%     drawLine3d(newLines(~isOrthogonal,:), 'r')
%
%   See also:
%   planes3d, lines3d, intersectLinePlane, projPointOnPlane
%
% ---------
% Author: oqilipo 
% Created: 2017-08-06
% Copyright 2017

p1 = projPointOnPlane(line(:,1:3), plane);
p2 = projPointOnPlane(line(:,1:3)+line(:,4:6), plane);

newLine=createLine3d(p1, p2);
isOrthogonal = ismembertol(p1,p2,'ByRows',true);


