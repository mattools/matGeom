%DEMO_POLYGONSIGNATURE_RECTANGLE  One-line description here, please.
%
%   output = demo_polygonSignature_rectangle(input)
%
%   Example
%   demo_polygonSignature_rectangle
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2023-12-20,    using Matlab 23.2.0.2409890 (R2023b) Update 3
% Copyright 2023 INRAE.


%% Input data

rect = [20 30  60 40];
poly = rectToPolygon(rect);
refPoint = [50 50];

figure; hold on; axis equal; axis([0 100 0 100]);
drawPolygon(poly, 'k');
drawPoint(refPoint, 'bo');

print(gcf, 'polygonSignature_rectangle_init.png', '-dpng');

%% compute signature

angles = 0:360;
signature = polygonSignature(poly, angles, refPoint);

figure; set(gca, 'fontsize', 14);
plot(angles, signature);
xlim(angles([1 end]));
set(gca, 'XTick', 0:45:360);
ylim([0 40]);
xlabel('Ray angle');
ylabel('Distance to reference point');
title('Polygon signature of rectangle')

print(gcf, 'polygonSignature_rectangle_signature.png', '-dpng');
