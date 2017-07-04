function varargout = cutFacesOffMesh(v, f, fLI)
%CUTFACESOFFMESH cuts faces off a mesh
%   [CUTV, CUTF] = cutFacesOffMesh(V, F, FLI) cuts faces off the mesh
%   by the logical index FLI into faces F of the mesh. The mesh is
%   represented by the vertex array V and the face array F. The result is
%   the new set of vertices CUTV and faces CUTF indexed by FLI.
%
%   [CUTV, CUTF] = cutFacesOffMesh(MESH, FLI) with the struct MESH 
%   containing the fields "vertices" (V) and "faces" (F)
%   
%   CUTMESH = cutFacesOffMesh(V, F, FLI) with the struct CUTMESH
%   containing the fields "vertices" (CUTV) and "faces" (CUTF)
%   
%   CUTMESH = cutFacesOffMesh(MESH, FLI) with the structs MESH and
%   CUTMESH containing the fields "vertices" and "faces"
%   
%   Example
%     [v, f] = createSoccerBall;
%     f = triangulateFaces(f);
%     fLI = true(length(f),1);
%     fLI(1:length(f)/2) = false;
%     [v2, f2] = cutFacesOffMesh(v, f, fLI);
%     drawMesh(v, f, 'faceColor', 'none', 'faceAlpha', .2);
%     drawMesh(v2, f2, 'faceAlpha', .7);
%     view(3); axis equal
%   
%   See also
%   meshes3d, drawMesh
%   
% ---------
% Authors: oqilipo, David Legland
% Created: 2017-07-04

% parse inputs
narginchk(2,3)
nargoutchk(1,2)

if nargin == 2
    fLI = f;
    [v, f] = parseMeshData(v);
end

p = inputParser;
islogicalIndexToFaces = @(x) islogical(x) && isequal(length(fLI), size(f,1));
addRequired(p,'fLI',islogicalIndexToFaces)
parse(p, fLI);
fLI=p.Results.fLI;

% algorithm
cutF = f(fLI,:);
[unqVertIds, ~, newVertIndices] = unique(cutF);
cutV = v(unqVertIds,:);
cutF = reshape(newVertIndices,size(cutF));

% parse outputs
if nargout == 1
    mesh.vertices=cutV;
    mesh.faces=cutF;
    varargout{1}=mesh;
else
    varargout{1}=cutV;
    varargout{2}=cutF;
end

end