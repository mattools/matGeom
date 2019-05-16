function varargout = removeMeshFaces(v, f, fI)
%REMOVEMESHFACES Remove faces from a mesh by face indices.
%   [V2, F2] = removeMeshFaces(V, F, FI) removes faces from the mesh by
%   the face indices FI into faces F of the mesh. The mesh is represented 
%   by the vertex array V and the face array F. The result is the new set 
%   of vertices V2 and faces F2 without the faces indexed by FI. FI can be
%   either a linear or a logical index.
%
%   [V2, F2] = removeMeshFaces(MESH, FI) with the struct MESH containing 
%   the fields "vertices" (V) and "faces" (F)
%   
%   MESH2 = removeMeshFaces(V, F, FI) with the struct MESH2 containing the
%   fields "vertices" (V2) and "faces" (F2)
%   
%   MESH2 = removeMeshFaces(MESH, FI) with the structs MESH and MESH2 
%   containing the fields "vertices" (V, V2) and "faces" (F, F2)
%   
%   Example
%     [v, f] = createSoccerBall;
%     f = triangulateFaces(f);
%     fI = true(length(f),1);
%     fI(1:length(f)/2) = false;
%     [v2, f2] = removeMeshFaces(v, f, fI);
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
    fI = f;
    [v, f] = parseMeshData(v);
end

p = inputParser;
isIndexToFaces = @(x) ...
    (islogical(x) && isequal(length(fI), size(f,1))) || ...
    (all(floor(x)==x) && min(x)>=1 && max(x)<=size(f,1));
addRequired(p,'fI',isIndexToFaces)
parse(p, fI);
if ~islogical(p.Results.fI)
    fI=false(size(f,1),1);
    fI(p.Results.fI)=true;
else
    fI=p.Results.fI;
end
    

% algorithm
f2 = f(~fI,:);
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