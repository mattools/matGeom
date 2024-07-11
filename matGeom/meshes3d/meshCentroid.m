function centroid = meshCentroid(varargin)
%MESHCENTROID Compute the centroid of the input mesh.
%
%   CENTROID = meshCentroid(V, F)
%   CENTROID = meshCentroid(MESH)
%   Computes the centroid of the input mesh.
%   The resulting centroid is usually different from he centroid computed
%   on the vertices (from the 'centroid' function, for example).
%
%   Example
%     mesh = readMesh('bunny_F1k.ply');
%     meshCentroid(mesh)
%     ans =
%         0.6496   -0.1670   -0.7924
%
%   See also
%     centroid, meshVolume, meshSurfaceArea, boundingBox3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2024-07-11,    using Matlab 24.1.0.2628055 (R2024a) Update 4
% Copyright 2024 INRAE.

[vertices, faces] = parseMeshData(varargin{:});

% ensure mesh has triangle faces
faces = triangulateFaces(faces);

% coordinates of each face vertex
V1 = vertices(faces(:,1),:);
V2 = vertices(faces(:,2),:);
V3 = vertices(faces(:,3),:);

% Area-weighted face normals (magnitude = 2 x triangle area)
normals = crossProduct3d(V2-V1, V3-V1);

% Zero-th order moment (same as volume enclosed by the mesh)
C = (V1 + V2 + V3) / 3;
m000 = sum(sum(normals.*C, 2)) / 6;
if m000 < eps
    warning('Mesh has negative volume, indicating that face normal orientations are reversed (i.e., pointing into the surface).')
end

% normalize the normals by the volume
% This avoids to normalize by m000 in the computation of centroid
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

% concatenate results
centroid = [m100 m010 m001];
