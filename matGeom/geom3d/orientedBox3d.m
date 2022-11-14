function [box3d, rotMat] = orientedBox3d(pts)
%ORIENTEDBOX3D Object-oriented bounding box of a set of 3D points.
%
%   OOBB = orientedBox3d(PTS)
%   REturns the oriented bounding box of the collection of points in the
%   N-by-3 array PTS. The result is given as:
%   [XC YC ZC  L W H  PHI THETA PSI]
%   where (XC,YC,ZC) corresponds to the center of the box, (L,W,H)
%   corresponds to the length, width, and depth of the box, and (PHI,
%   THETA, PSI) is the orientation of the box as Euler angles.
%
%   [OOBB, ROT] = orientedBox3d(PTS)
%   Also returns the rotation matrix of the point cloud, as a 3-by-3
%   numeric array.
%
%   Example
%     [v, f] = sphereMesh;
%     phi=-360+720*rand; theta=-360+720*rand; psi=-360+720*rand;
%     angles = [phi, theta, psi];
%     rotMat = eulerAnglesToRotation3d(angles);
%     rotMat(1:3,4) = randi([-100,100],3,1);
%     scale = [randi([7,9],1,1), randi([4,6],1,1), randi([1,3],1,1)];
%     pts = transformPoint3d(bsxfun(@times, v, scale), rotMat);
%     box3d = orientedBox3d(pts);
%     figure; drawPoint3d(pts, '.'); 
%     axis equal; xlabel('x'); ylabel('y'); zlabel('z');
%     drawCuboid(box3d, 'FaceColor', 'none');
%
%   See also
%     meshes3d, drawCuboid, rotation3dToEulerAngles

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2015-12-01,    using Matlab 8.6.0.267246 (R2015b)
% Copyright 2015 INRA - Cepia Software Platform.

tri = convhulln(pts);
nFaces = size(tri, 1);

%% identify index of face with smallest width
indMinBreadth = 0;
minBreadth = Inf;
for iFace = 1:nFaces
    faceInds = tri(iFace, :);
    plane = createPlane(pts(faceInds, :));
    
    breadth = max(abs(distancePointPlane(pts, plane)));
    
    if breadth < minBreadth
        minBreadth = breadth;
        indMinBreadth = iFace;
    end
end

% compute projection on reference plane
refPlane = createPlane(pts(tri(indMinBreadth, :), :));
pts2d = planePosition(projPointOnPlane(pts, refPlane), refPlane);

% compute 2D OOBB for projected points
box2d = orientedBox(pts2d);

% extract reference points from planar OOBB: the center, and two direction
% vectors
center2d = box2d(1:2);
L1 = box2d(3);
L2 = box2d(4);
markers2d = [0 0; L1/2 0; 0 L2/2];

% orient reference points to 2d basis
theta2d = box2d(5);
rot = createRotation(deg2rad(theta2d));
tra = createTranslation(center2d);
transfo = tra * rot;
markers2d = transformPoint(markers2d, transfo);

% backprojection to 3D space
markers3d = planePoint(refPlane, markers2d);

% compute 3D vectors and center
centerProj = markers3d(1,:);
v1n = normalizeVector3d(markers3d(2,:) - centerProj);
v2n = normalizeVector3d(markers3d(3,:) - centerProj);

% compute rotation matrix and convert to Euler Angles
v3n = crossProduct3d(v1n, v2n);
rotMat = [v1n' v2n' v3n'];
boxAngles = rotation3dToEulerAngles(rotMat);

% create 3D object-oriented bounding box
boxCenter3d = centerProj + v3n * minBreadth/2;
box3d = [boxCenter3d L1 L2 minBreadth boxAngles];
