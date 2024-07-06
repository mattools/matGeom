function BE = meshBoundaryEdges(varargin)
%MESHBOUNDARYEDGES Determine the boundary edges of a mesh.
%
%   BE = meshBoundaryEdges(V, F)
%   Determine for each edge of the mesh if it is a boundary edge of the 
%   mesh.
%
%   Example
%     run createTrefoilKnot.m
%     f2 = triangulateFaces(f2);
%     % clip the mesh with a plane
%     plane = createPlane([0 0 0], [-1 -2 3]);
%     [v2, f2] = clipMeshVertices(v2, f2, plane, 'shape', 'plane');
%     % draw the mesh
%     figure('color','w'); drawMesh(v2, f2); axis equal; view(3);
%     % calculate the boundary edges
%     be2 = meshBoundaryEdges(v2, f2);
%     % draw boundary edges
%     drawEdge3d([v2(be2(:,1),:) v2(be2(:,2),:)], 'LineWidth',4,'Color','g')
%
%   See also 
%     meshes3d, meshBoundary, meshBoundaryVertexIndices, meshEdgeFaces, 
%     meshBoundaryEdgeIndices
%
%   Source:
%     is_boundary_facet.m by Alec Jacobson:
%       https://github.com/alecjacobson/gptoolbox

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-05-15, using Matlab 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023-2024

[V, E, F] = parseMeshData(varargin{:});

% Compute edge-vertex map if not specified
if isempty(E)
    E = meshEdges(V, F);
end

switch size(F,2)
    case 3
        allE = [F(:,[2 3]);F(:,[3 1]);F(:,[1 2])];
    case 4
        allE = [ ...
            F(:,2) F(:,4) F(:,3); ...
            F(:,1) F(:,3) F(:,4); ...
            F(:,1) F(:,4) F(:,2); ...
            F(:,1) F(:,2) F(:,3); ...
            ];
end

[~,~,EMAP] = unique(sort([E;allE],2),'rows');
N = accumarray(EMAP,1);

% Look of occurances of 2: one for original and another for boundary
B = N(EMAP(1:size(E,1)))==2;

BE = E(B,:);
