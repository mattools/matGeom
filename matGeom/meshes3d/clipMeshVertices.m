function [v2, f2] = clipMeshVertices(v, f, b, varargin)
%CLIPMESHVERTICES Clip vertices of a surfacic mesh and remove outer faces
%
%   [V2, F2] = clipMeshVertices(V, F, B)
%   Clip a mesh represented by vertex array V and face array F, with the
%   box represented by B. The result is the set of vertices contained in
%   the box, and a new set of faces corresponding to original faces with
%   all vertices within the box.
%   
%   [V2, F2] = clipMeshVertices(..., 'inside',false) removes the inner 
%   faces instead of the outer faces.
%
%   Example
%     [v, f] = createSoccerBall;
%     box = [-.8 2 -.8 2 -.8 2];
%     [v2, f2] = clipMeshVertices(v, f, box);
%     figure; drawMesh(v2, f2, 'faceAlpha', .7); 
%     view(3); axis equal;
%
%   See also
%   meshes3d, clipPoints3d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-04-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% if input is given as a structure, parse fields
if isstruct(v)
    b = f;
    f = v.faces;
    v = v.vertices;
end

parser = inputParser;
addOptional(parser,'inside',true,@islogical);
parse(parser,varargin{:});

% clip the vertices
[v2, indVertices] = clipPoints3d(v, b);
if ~parser.Results.inside
    indVertices=find(~ismember(v,v2,'rows'));
    v2=v(indVertices,:);
end

% create index array for face indices relabeling
refInds = zeros(size(indVertices));
for i = 1:length(indVertices)
    refInds(indVertices(i)) = i;
end

% select the faces with all vertices within the box
if isnumeric(f)
    % Faces given as numeric array
    indFaces = sum(~ismember(f, indVertices), 2) == 0;
    f2 = refInds(f(indFaces, :));
    
elseif iscell(f)
    % Faces given as cell array
    nFaces = length(f);
    indFaces = false(nFaces, 1);
    for i = 1:nFaces
        indFaces(i) = sum(~ismember(f{i}, indVertices), 2) == 0;
    end
    f2 = f(indFaces, :);
    
    % re-label indices of face vertices (keeping horizontal index array)
    for i = 1:length(f2)
        f2{i} = refInds(f2{i})';
    end
end
