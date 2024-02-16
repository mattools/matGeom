%DEMO_REGISTERPOINTS3D_ICP_BUNNY  One-line description here, please.
%
%   output = demo_registerPoints3d_icp_bunny(input)
%
%   Example
%   demo_registerPoints3d_icp_bunny
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2024-02-16,    using Matlab 23.2.0.2459199 (R2023b) Update 5
% Copyright 2024 INRAE.

%% Read data

% read sample mesh
[v, ~] = readMesh('bunny_F5k.ply');

% create arbitrary transform on the points
rot = eulerAnglesToRotation3d([30 20 10]);
tra = createTranslation3d([4 3 2]);
transfo0 = tra * rot;

% transform initial points, adding some noise
rng(17);
v2 = transformPoint3d(v, transfo0) + rand(size(v)) * 0.5;

% display initial and transformed points
figure; hold on; axis equal; view([25 25]);
drawPoint3d(v, 'k.');
drawPoint3d(v2, 'b.');


%% Apply ICP registration

% run registration algorithm of V2 points onto V points
[transfo, v2t, errors, times] = registerPoints3d_icp(v2, v, 'NIters', 25);
fprintf('elapsed time: %5.2f s\n', times(end));

% display result of registration
figure; hold on; axis equal; view([25 25]);
drawPoint3d(v, 'k.');
drawPoint3d(v2t, 'm.');

% also display evolution of error
figure;
plot(0:25, errors);
xlabel('Iterations');
ylabel('RMSE');
