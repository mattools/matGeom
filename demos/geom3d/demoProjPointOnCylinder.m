function demoProjPointOnCylinder
%DEMOPROJPOINTONCYLINDER demo for projPointOnCylinder
%
%   Example
%     demoProjPointOnCylinder
%
%   See also
%

% ---------
% Author: oqilipo
% Created: 2021-04-17, using R2020b
% Copyright 2021

% Random cylinder
p1 = randi([-10,10],1,3);
p2 = randi([-10,10],1,3);
r = randi([2,10]);
cyl = [p1, p2, r];
% Random points
pt = randi([-10,10],5,3);
[ptProj_open, ptProj_closed] = deal(nan(length(pt),3));
for p=1:length(pt)
    ptProj_open(p,:) = projPointOnCylinder(pt(p,:), cyl);
    ptProj_closed(p,:) = projPointOnCylinder(pt(p,:), cyl,'close');
end

figure('color','w','position',[50 50 1600 1000]);
nexttile; hold on
drawCylinder(cyl,'closed','FaceAlpha',0.5)
drawPoint3d(pt)
drawPoint3d(ptProj_open,'mo')
drawPoint3d(ptProj_closed,'co')
ho = drawEdge3d([pt ptProj_open],'m');
hc = drawEdge3d([pt ptProj_closed],'c');
axis equal tight; light; view(3)
title('Random case')

%% Special cases 
titles{1} = 'Inside radius and closer to the top than to the cylinder surface';
pts(1,:) = [2,-3,-4];
cyls(1,:) = [5,8,-3,4,-4,1,9];
titles{2} = 'Inside radius and in the top plane';
pts(2,:) = [-4,-2,8];
cyls(2,:) = [2,6,-4,-6,-4,2,9];
titles{3} = 'Outside radius and in the top plane';
pts(3,:) = [6,6,-2];
cyls(3,:) = [-8,8,-6,2,1,-7,2];
titles{4} = 'On radius';
pts(4,:) = [-2,0,4];
cyls(4,:) = [7,-6,-6,7,3,9,9];
titles{5} = 'On cylinder axis';
pts(5,:) = [0,0,4];
cyls(5,:) = [0,0,0,0,0,9,9];
[ptProjs_open, ptProjs_closed] = deal(nan(size(pts,1),3));
for p=1:size(pts,1)
    ptProjs_open(p,:) = projPointOnCylinder(pts(p,:), cyls(p,:));
    ptProjs_closed(p,:) = projPointOnCylinder(pts(p,:), cyls(p,:),'close');
    nexttile; hold on
    drawCylinder(cyls(p,:),'closed','FaceAlpha',0.5)
    drawPoint3d(pts(p,:))
    drawPoint3d(ptProjs_open(p,:),'mo')
    drawPoint3d(ptProjs_closed(p,:),'co')
    ho = drawEdge3d([pts(p,:) ptProjs_open(p,:)],'m');
    hc = drawEdge3d([pts(p,:) ptProjs_closed(p,:)],'c');
    axis equal tight; light; view(3)
    title(titles{p})
end
legend([ho(1), hc(1)], 'Open / infinite cylinder', 'Closed / finite cylinder',...
    'Location','northoutside')

end