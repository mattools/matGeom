%DEMODRAWELLIPSOID  One-line description here, please.
%
%   output = demoDrawEllipsoid(input)
%
%   Example
%   demoDrawEllipsoid
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-10-28,    using Matlab 26.2.0.3386108 (R2026b)
% Copyright 2026 INRAE.


%% Common data

center = [50 50 50];
orient = [120 40 10];
azel =  [120 30];

%% Oblate ellipsoid

ell1 = [center 20 50 50 orient];

figure; hold on; axis equal; axis([0 100 0 100 0 100]);
drawEllipsoid(ell1, 'faceColor', 'g', ...
    'nPhi', 100, 'nTheta', 100, ...
    'drawEllipses', true, 'EllipseColor', 'b', 'EllipseWidth', 2);
view(azel); light;
print(gcf, 'ellipsoid_oblate.png', '-dpng');


%% Prolate ellipsoid

ell2 = [center 50 20 20 orient];

figure; hold on; axis equal; axis([0 100 0 100 0 100]);
drawEllipsoid(ell2, 'faceColor', 'g', ...
    'nPhi', 100, 'nTheta', 100, ...
    'drawEllipses', true, 'EllipseColor', 'b', 'EllipseWidth', 2);
view(azel); light;
print(gcf, 'ellipsoid_prolate.png', '-dpng');
