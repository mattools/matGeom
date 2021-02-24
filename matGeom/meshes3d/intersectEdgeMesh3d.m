function [points, pos, faceInds] = intersectEdgeMesh3d(edge, varargin)
% Intersection points of a 3D edge with a mesh.
%
%   INTERS = intersectEdgeMesh3d(EDGE, VERTICES, FACES)
%   Compute the intersection points between a 3D edge and a 3D mesh defined
%   by vertices and faces.
%
%   [INTERS, POS, INDS] = intersectEdgeMesh3d(EDGE, VERTICES, FACES)
%   Also returns the position of each intersection point on the input edge,
%   and the index of the intersected faces.
%   For edges, the values of POS are expected to be comprised between 0 and
%   1.
%   
%   Example
%     [V, F] = createCube;
%     edge = [-1 0.5 0.5  +3 0.5 0.5];
%     pts = intersectEdgeMesh3d(edge, V, F)
%     pts =
%         1.0000    0.5000    0.5000
%              0    0.5000    0.5000
%
%   See also
%     meshes3d, interesectLineMesh3d, triangulateFaces
%

% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% Created: 2021-02-24,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2021 INRA - Cepia Software Platform.

% perform computation on supporting line
line = edgeToLine3d(edge);
[points, pos, faceInds] = intersectLineMesh3d(line, varargin{:});

% identifies intersection points within parameterization bounds
inds = pos >= 0 & pos <= 1;

% select relevant results
points = points(inds, :);
