function meshes = splitMesh(vertices, faces, varargin)
%SPLITMESH Return the connected components of a mesh
%
%   MESHES = splitMesh(VERTICES, FACES) returns the connected components of
%   the mesh defined by vertices and faces as a struct array with the  
%   fields vertices and faces sorted by increasing vertex number
%
%   MESHES = splitMesh(MESH) with the vertices-faces-struct MESH is also
%   possible
%   
%   ... = splitMesh(..., 'mostVertices') returns only the component with
%   the most vertices
%
%   Example
%     [v1, f1] = boxToMesh([1 0 -1 0 -1 0]);
%     [v2, f2] = boxToMesh([-1 0 1 0 -1 0]);
%     [v3, f3] = createSoccerBall;
%     f1 = triangulateFaces(f1);
%     f2 = triangulateFaces(f2);
%     f3 = triangulateFaces(f3);
%     [vertices, faces] = concatenateMeshes(v1, f1, v3, f3, v2, f2);
%     meshes = splitMesh(vertices, faces);
%     figure('color','w'); view(3); axis equal
%     cmap=hsv(length(meshes));
%     for m=1:length(meshes)
%         drawMesh(meshes(m), cmap(m,:))
%     end
%
%   See also
%     concatenateMeshes
%
%   Source
%     Local functions are part of the gptoolbox of Alec Jacobson
%     https://github.com/alecjacobson/gptoolbox
%
% ---------
% Author: oqilipo
% Created: 2017-09-17
% Copyright 2017

% input parsing
if isstruct(vertices)
    if nargin > 1; varargin = [faces, varargin]; end
    [vertices, faces]=parseMeshData(vertices);
end

parser = inputParser;
validStrings = {'all','mostVertices'};
addOptional(parser,'components','all',@(x) any(validatestring(x, validStrings)));
parse(parser,varargin{:});

% algorithm
CC = connected_components(faces);
[a,~]=hist(CC,unique(CC));
[~,b] = sort(a);
meshes=repmat(struct('vertices',[],'faces',[]),length(b),1);
for cc=b
    meshes(cc)=removeMeshVertices(vertices, faces, ~(CC'==b(cc)));
end

% output parsing
switch parser.Results.components
    case 'mostVertices'
        meshes=meshes(end);
end

end


%% Locals functions are part of the gptoolbox by Alec Jacobson
function C = connected_components(F)
% CONNECTED_COMPONENTS Determine the connected components of a mesh
% described by the simplex list F. Components are determined with respect
% to the edges of the mesh. That is, a single component may contain
% non-manifold edges and vertices.
%
% C = connected_components(F)
%
% Inputs:
%   F  #F by simplex-size list of simplices
% Outputs:
%   C  #V list of ids for each CC
%
% Examples:
%  trisurf(F,V(:,1),V(:,2),V(:,3), ...
%    connected_components([F;repmat(size(V,1),1,3)]));

% build adjacency list
A = adjacency_matrix(F);
[~,C] = conncomp(A);
end

function [A] = adjacency_matrix(E)
% ADJACENCY_MATRIX Build sparse adjacency matrix from edge list or face list
%
% [A] = adjacency_matrix(E)
% [A] = adjacency_matrix(F)
% [A] = adjacency_matrix(T)
%
% Inputs:
%   E  #E by 2 edges list
%   or
%   F  #F by 3 triangle list
%   or
%   T  #F by 4 tet list
% Outputs:
%   A  #V by #V adjacency matrix (#V = max(E(:)))
%
% See also: facet_adjacency_matrix
%

if size(E,2)>2
    F = E;
    E = meshEdges(F);
end

A = sparse([E(:,1) E(:,2)],[E(:,2) E(:,1)],1);
end

function [S,C] = conncomp(G)
% CONNCOMP Drop in replacement for graphconncomp.m from the bioinformatics
% toobox. G is an n by n adjacency matrix, then this identifies the S
% connected components C. This is also an order of magnitude faster.
%
% [S,C] = conncomp(G)
%
% Inputs:
%   G  n by n adjacency matrix
% Outputs:
%   S  scalar number of connected components
%   C

% Transpose to match graphconncomp
G = G';

[p,~,r] = dmperm(G+speye(size(G)));
S = numel(r)-1;
C = cumsum(full(sparse(1,r(1:end-1),1,1,size(G,1))));
C(p) = C;
end

