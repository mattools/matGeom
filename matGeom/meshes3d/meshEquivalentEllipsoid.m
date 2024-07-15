function ellipsoid = meshEquivalentEllipsoid(vertices, faces, varargin)
%MESHEQUIVALENTELLIPSOID Equivalent ellipsoid with same moments as the given mesh.
%
%   ELLI = meshEquivalentEllipsoid(V, F)
%   ELLI = meshEquivalentEllipsoid(MESH)
%
%   Example
%     mesh = readMesh('bunny_F1k.ply');
%     figure; hold on; axis equal; axis([-10 10 -6 8 -8 12]); view([20 20]);
%     drawMesh(mesh, 'faceColor', [0.7 0.7 0.7]);
%     elli = meshEquivalentEllipsoid(mesh);
%     drawEllipsoid(elli, 'facecolor', 'g', 'facealpha', 0.7, ...
%         'drawEllipses', true, 'EllipseColor', 'b', 'EllipseWidth', 3);
%
%   References
%   Rigid body parameters of closed surface, by Anton Semechko
%   https://fr.mathworks.com/matlabcentral/fileexchange/48913-rigid-body-parameters-of-closed-surface-meshes
%
%   See also
%     meshes3d, drawEllipsoid, meshCentroid, equivalentEllipsoid
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2024-07-15,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE.

% check the case of mesh given as structure
if isstruct(vertices)
    faces = vertices.faces;
    vertices = vertices.vertices;
end

% ensure mesh has triangle faces
faces = triangulateFaces(faces);

% coordinates of each face vertex
V1 = vertices(faces(:,1),:);
V2 = vertices(faces(:,2),:);
V3 = vertices(faces(:,3),:);

% Area weighted face normals (magnitude = 2 x triangle area)
normals = crossProduct3d(V2-V1, V3-V1);

% Zero-th order moment (same as volume enclosed by the mesh)
C = (V1 + V2 + V3) / 3;
m000 = sum(sum(normals.*C, 2)) / 6;
if m000 < eps
    warning('Mesh has negative volume, indicating that face normal orientations are reversed (i.e., pointing into the surface).')
end

% normalize the normals by the volume
% This avoids to normalize by m000 in the computation of center and radius
normals = normals / m000;

% extract coordinates of each face vertex
x1 = V1(:,1); y1=V1(:,2); z1=V1(:,3);
x2 = V2(:,1); y2=V2(:,2); z2=V2(:,3);
x3 = V3(:,1); y3=V3(:,2); z3=V3(:,3);

% First order moments
% (together they specify the centroid of the region  enclosed by the mesh) 
mxx = ((x1+x2).*(x2+x3) + x1.^2 + x3.^2) / 12;
myy = ((y1+y2).*(y2+y3) + y1.^2 + y3.^2) / 12;
mzz = ((z1+z2).*(z2+z3) + z1.^2 + z3.^2) / 12;

mxy = ((x1+x2+x3).*(y1+y2+y3) + x1.*y1 + x2.*y2 + x3.*y3) / 24;
mxz = ((x1+x2+x3).*(z1+z2+z3) + x1.*z1 + x2.*z2 + x3.*z3) / 24;
myz = ((y1+y2+y3).*(z1+z2+z3) + y1.*z1 + y2.*z2 + y3.*z3) / 24;

m100 = sum(sum(normals .* [mxx 2*mxy 2*mxz], 2)) / 6;
m010 = sum(sum(normals .* [2*mxy myy 2*myz], 2)) / 6;
m001 = sum(sum(normals .* [2*mxz 2*myz mzz], 2)) / 6;
center = [m100 m010 m001];
    
% Second order moments 
% (used to determine elements of the inertia tensor)
mxxx = ((x1+x2+x3).*(x1.^2+x2.^2+x3.^2) + x1.*x2.*x3) / 20; 
myyy = ((y1+y2+y3).*(y1.^2+y2.^2+y3.^2) + y1.*y2.*y3) / 20; 
mzzz = ((z1+z2+z3).*(z1.^2+z2.^2+z3.^2) + z1.*z2.*z3) / 20; 

mxyy = ((3*y1+y2+y3).*x1.^2 + (y1+3*y2+y3).*x2.^2 + (y1+y2+3*y3).*x3.^2 + (2*y1+2*y2+y3).*x1.*x2 + (2*y1+y2+2*y3).*x1.*x3 + (y1+2*y2+2*y3).*x2.*x3)/60;
mxzz = ((3*z1+z2+z3).*x1.^2 + (z1+3*z2+z3).*x2.^2 + (z1+z2+3*z3).*x3.^2 + (2*z1+2*z2+z3).*x1.*x2 + (2*z1+z2+2*z3).*x1.*x3 + (z1+2*z2+2*z3).*x2.*x3)/60;
myxx = ((3*x1+x2+x3).*y1.^2 + (x1+3*x2+x3).*y2.^2 + (x1+x2+3*x3).*y3.^2 + (2*x1+2*x2+x3).*y1.*y2 + (2*x1+x2+2*x3).*y1.*y3 + (x1+2*x2+2*x3).*y2.*y3)/60;
myzz = ((3*z1+z2+z3).*y1.^2 + (z1+3*z2+z3).*y2.^2 + (z1+z2+3*z3).*y3.^2 + (2*z1+2*z2+z3).*y1.*y2 + (2*z1+z2+2*z3).*y1.*y3 + (z1+2*z2+2*z3).*y2.*y3)/60;
mzyy = ((3*y1+y2+y3).*z1.^2 + (y1+3*y2+y3).*z2.^2 + (y1+y2+3*y3).*z3.^2 + (2*y1+2*y2+y3).*z1.*z2 + (2*y1+y2+2*y3).*z1.*z3 + (y1+2*y2+2*y3).*z2.*z3)/60;
mzxx = ((3*x1+x2+x3).*z1.^2 + (x1+3*x2+x3).*z2.^2 + (x1+x2+3*x3).*z3.^2 + (2*x1+2*x2+x3).*z1.*z2 + (2*x1+x2+2*x3).*z1.*z3 + (x1+2*x2+2*x3).*z2.*z3)/60;
mxyz = ((x1+x2+x3).*(y1+y2+y3).*(z1+z2+z3) - (y2.*z3+y3.*z2-4*y1.*z1).*x1/2 -(y1.*z3+y3.*z1-4*y2.*z2).*x2/2 - (y1.*z2+y2.*z1-4*y3.*z3).*x3/2)/60;

m110 = sum(sum(normals .* [ mxyy   myxx  2*mxyz], 2)) / 6;
m101 = sum(sum(normals .* [ mxzz  2*mxyz   mzxx], 2)) / 6;
m011 = sum(sum(normals .* [2*mxyz   myzz   mzyy], 2)) / 6;
m200 = sum(sum(normals .* [   mxxx  3*mxyy  3*mxzz], 2)) / 9;
m020 = sum(sum(normals .* [3*myxx     myyy  3*myzz], 2)) / 9;
m002 = sum(sum(normals .* [3*mzxx  3*mzyy     mzzz], 2)) / 9;

% Computes inertia tensor
Ixx = m200 - m100^2;
Iyy = m020 - m010^2;
Izz = m002 - m001^2;
Ixy = m110 - m100 * m010;
Ixz = m101 - m100 * m001;
Iyz = m011 - m010 * m001;
I = [Ixx Ixy Ixz; Ixy Iyy Iyz; Ixz Iyz Izz];

% apply a principal component analysis to extract inertia axes
[U, S] = svd(I);

% extract length of each semi axis
radii = sqrt(5) * sqrt(diag(S))';

% sort axes from greatest to lowest
[radii, ind] = sort(radii, 'descend');
U = U(ind, :);

% format U to ensure first axis points to positive x direction
if U(1,1) < 0
    U = -U;
    % keep matrix determinant positive
    U(:,3) = -U(:,3);
end

% convert axes rotation matrix to Euler angles
angles = rotation3dToEulerAngles(U);

% concatenate result to form an ellipsoid object
ellipsoid = [center radii angles];

