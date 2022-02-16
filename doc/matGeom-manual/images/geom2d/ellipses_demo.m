%ELLIPSES_DEMO  One-line description here, please.
%
%   output = ellipses_demo(input)
%
%   Example
%   ellipses_demo
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2019-08-09,    using Matlab 9.6.0.1072779 (R2019a)
% Copyright 2019 INRA - Cepia Software Platform.

load fisherIris;
figure; hold on; set(gca, 'fontsize', 14);
colors = {'b', 'g', 'm'};
hi = zeros(1,3);
for i = 1:3
  pts = meas((1:50)+(i-1)*50, 3:4);
  hi(i) = drawPoint(pts, 'marker', 'o', 'color', colors{i}, 'markerfacecolor', colors{i});
  drawEllipse(equivalentEllipse(pts), 'color', colors{i}, 'linewidth', 2);
end
legend(hi, species([1 51 101]), 'Location', 'NorthWest');

print(gcf, 'equivalentEllipse_demo.png');