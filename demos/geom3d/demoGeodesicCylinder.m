function demoGeodesicCylinder
%DEMOGEODESICCYLINDER demo for geodesicCylinder
%
%   Example
%     demoGeodesicCylinder
%
%   See also
%

% ---------
% Author: oqilipo
% Created: 2021-04-17, using R2020b
% Copyright 2021

%% Random case
% Random cylinder
p1 = randi([-10,10],1,3);
p2 = randi([-10,10],1,3);
r = randi([2,10]);
cyl = [p1, p2, r];
% Random points
pts = randi([-10,10],2,3);

[geo, arcLength, conGeo, conGeoLength] = geodesicCylinder(pts, cyl,'n',1000);

% Visu
figure('color','w','position',[50 50 1600 500]);
nexttile; hold on
drawCylinder(cyl,'FaceAlpha',0.5);
drawPoint3d(pts);
drawEdge3d([pts geo([1 end],:)],'c');
drawPolyline3d(geo);
drawPolyline3d(conGeo);
axis equal tight; light; view(3)
title('Random case')

disp(['Analytical length of the geodesic = ',num2str(arcLength)])
disp(['Numerical length of the geodesic  = ',num2str(polylineLength(geo))])
disp(['Analytical length of the conjugate geodesic = ',num2str(conGeoLength)])
disp(['Numerical length of the conjugate geodesic  = ',num2str(polylineLength(conGeo))])

%% Special case (same theta)
cyl = [0,0,0,0,0,8,4];
pts = [1,-4,2;1,-4,6];

[geo, ~, conGeo, ~] = geodesicCylinder(pts, cyl);

% Visu
nexttile; hold on
drawCylinder(cyl,'FaceAlpha',0.5);
drawPoint3d(pts);
drawEdge3d([pts geo([1 end],:)],'c');
drawPolyline3d(geo);
drawPolyline3d(conGeo);
axis equal tight; light; view(3)
title('Special case: same theta')


%% Line-cylinder intersection
cyl = [-2,4,9,7,0,5,5];
line3d = createLine3d([-4 2 4], [5 -3 8]);

pts = intersectLineCylinder(line3d, cyl);
[geo, ~, conGeo, ~] = geodesicCylinder(pts, cyl);

% Visu
nexttile; hold on
drawCylinder(cyl,'FaceAlpha',0.5);
drawLine3d(line3d);
hp = drawPoint3d(pts);
hpp = drawEdge3d([pts geo([1 end],:)],'c');
hg = drawPolyline3d(geo);
hcg = drawPolyline3d(conGeo);
axis equal tight; light; view(3)
title('Line-cylinder intersection')
legend([hp, hpp(1), hg, hcg],...
    'Points','Points proj. on Cylinder','Geodesic','Conjugate geodesic');

end