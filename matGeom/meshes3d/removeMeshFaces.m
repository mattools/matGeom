function varargout = removeMeshFaces(v, f, fLI)
%REMOVEMESHFACES removes faces from a mesh by a logical face index
%   [V2, F2] = removeMeshFaces(V, F, FLI) removes faces from the mesh by
%   the logical index FLI into faces F of the mesh. The mesh is represented 
%   by the vertex array V and the face array F. The result is the new set 
%   of vertices V2 and faces F2 without the faces indexed by FLI.
%
%   [V2, F2] = removeMeshFaces(MESH, FLI) with the struct MESH 
%   containing the fields "vertices" (V) and "faces" (F)
%   
%   MESH2 = cutFacesOffMesh(V, F, FLI) with the struct MESH2
%   containing the fields "vertices" (V2) and "faces" (F2)
%   
%   MESH2 = cutFacesOffMesh(MESH, FLI) with the structs MESH and
%   MESH2 containing the fields "vertices" (V, V2) and "faces" (F, F2)
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
f2 = f(~fLI,:);
[unqVertIds, ~, newVertIndices] = unique(f2);
v2 = v(unqVertIds,:);
f2 = reshape(newVertIndices,size(f2));

% parse outputs
if nargout == 1
    mesh2.vertices=v2;
    mesh2.faces=f2;
    varargout{1}=mesh2;
else
    varargout{1}=v2;
    varargout{2}=f2;
end

end