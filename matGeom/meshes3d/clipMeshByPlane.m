function [v2, f2, bE] = clipMeshByPlane(v, f, plane, varargin)
%CLIPMESHBYPLANE Clip a mesh by a plane.
%
%   [V2, F2] = cutMeshByPlane(V, F, PLANE)
%   Clip a mesh defined by the vertices V and faces F by a PLANE and return
%   the part of the mesh (V2, F2) above the plane.
%
%   [V2, F2, ENEW] = cutMeshByPlane(V, F, PLANE)
%   Additonally returns the new boundary edges created by the clipping of
%   the mesh.
%
%   [...] = cutMeshByPlane(V, F, PLANE, 'part', 'below')
%   Gives the part of the mesh below the plane. The options are:
%       'part','above': Mesh above the plane [default]
%       'part','below': Mesh below the plane
%
%   Example
%     % Create trefoil curve
%     nPoints = 200; % Number of vertices of trefoil curve
%     thickness = .5; % Thickness of the 3D mesh
%     nCorners = 16; % Number of corners around each curve vertex
%     t = linspace(0, 2*pi, nPoints + 1); % parameterisation variable
%     t(end) = [];
%     % Trefoil curve coordinates
%     curve(:,1) = sin(t) + 2 * sin(2 * t);
%     curve(:,2) = cos(t) - 2 * cos(2 * t);
%     curve(:,3) = -sin(3 * t);
%     % Create surrounding mesh
%     [v2, f2] = curveToMesh(curve, thickness, nCorners);
%     f2 = triangulateFaces(f2);
%     % Clip the mesh by a plane
%     plane = createPlane([0 0 0], [0.5 0.5 1]);
%     [v2, f2, bE] = clipMeshByPlane(v2, f2, plane, 'part','above');
%     % Display results
%     figure('color','w'); 
%     drawPolygon3d(curve, 'LineWidth', 4, 'color', 'b');
%     axis equal; view(3);
%     drawMesh(v2, f2, 'FaceAlpha', 0.5);
%     drawPlane3d(plane)
%     drawEdge3d([v2(bE(:,1),:),v2(bE(:,2),:)],'Color','g','LineWidth',4)
%   
%   See also 
%     cutMeshByPlane, intersectPlaneMesh
%
%   Source
%     half_space_intersect.m by Alec Jacobson:
%       https://github.com/alecjacobson/gptoolbox

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-05-18, using Matlab 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023

%% Parse input
if isstruct(v)
    if nargin > 2
        varargin = [plane, varargin]; 
    end
    plane = f;
    f = v.faces;
    v = v.vertices;
end

p = inputParser;
addRequired(p,'plane',@isPlane)
validStrings = {'above','below'};
addParameter(p,'part','above',@(x) any(validatestring(x, validStrings)))
parse(p, plane, varargin{:});
part=p.Results.part;

p = plane(1:3);
switch part
    case 'above'
        n = planeNormal(plane);
    case 'below'
        n = planeNormal(reversePlane(plane));
end

% Homogeneous coordinates
IV = sum(bsxfun(@times, [v(:,1:3) ones(size(v,1), 1)], [n(:)' -dot(p,n)]), 2);
IF = IV(f);
IF = reshape(IF, size(f));

I13 = sum(IF<0, 2) == 1;
[VV1, E13, ~, F13above, ~] = one_below(v, f(I13,:), IF(I13,:));

I31 = sum(IF>0, 2) == 1;
[VV2, E31, F31below, ~, ~] = one_below(VV1, f(I31,:), -IF(I31,:));

above = all(IF>=0, 2);
FF2 = [f(above,:); F13above; F31below];
% birth = [find(above); repmat(find(I13),2,1); find(I31)];
EE2 = [E13; E31];

% Remove duplicate vertices
bbd = norm(max(v)-min(v));
[vIdx, fIdx] = removeDuplicateVertices(VV2, FF2, 1e-14*bbd, 'IndexOutput',1);
VV3 = VV2(vIdx,:);
FF3 = fIdx(FF2);
EE3 = fIdx(EE2);
% Remove unreferenced/unindexed vertices
[vIdx, fIdx] = removeUnreferencedVertices(VV3, FF3, 'IndexOutput',1);
v2 = VV3(vIdx,:);
f2 = fIdx(FF3);
bE = fIdx(EE3);

end

function [U, E, Fbelow, Fabove, BC] = one_below(V, F, IF)

[~, J] = min(IF, [], 2);
I = sub2ind(size(F), repmat(1:size(F,1), size(F,2),1)', mod([J J+1 J+2]-1, 3)+1);
lambda = IF(I(:,2:3))./bsxfun(@minus,IF(I(:,2:3)),IF(I(:,1)));
BC = sparse( ...
    repmat((1:size(F,1)*2)', 1, 2), ...
    [repmat(F(I(:,1)),2,1) reshape(F(I(:,2:3)), size(F,1)*2,1)], ...
    [lambda(:) 1-lambda(:)], ...
    size(F,1)*2, size(V,1));
E = size(V, 1) + bsxfun(@plus, 1:size(F,1), [0;1]*size(F,1))';
U = [V; BC*V];
Fbelow = [F(I(:,1)) E];
Fabove = [F(I(:,2)) fliplr(E); F(I(:,2:3)) E(:,2)];

end
