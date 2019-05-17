function varargout = clipMeshVertices(v, f, b, varargin)
%CLIPMESHVERTICES Clip vertices of a surfacic mesh and remove outer faces.
%
%   [V2, F2] = clipMeshVertices(V, F, B)
%   Clip a mesh represented by vertex array V and face array F, with the
%   box represented by B. The result is the set of vertices contained in
%   the box, and a new set of faces corresponding to original faces with
%   all vertices within the box.
%   
%   [V2, F2] = clipMeshVertices(..., 'shape', 'sphere') Specify the shape.
%   Default is 'box'. But it is also possible to use 'sphere' or 'plane'.
%   
%   [V2, F2] = clipMeshVertices(..., 'inside', false) removes the inner 
%   faces instead of the outer faces.
%
%   [V2, F2] = clipMeshVertices(..., 'trimMesh', TF)
%   Also specifies if the isolated vertices need to be removed (TF=true) ot
%   not (TF=false). Default is false.
%
%
%   Example
%     [v, f] = createSoccerBall;
%     f = triangulateFaces(f);
%     box = [0 2 -1 2 -.5 2];
%     [v2, f2] = clipMeshVertices(v, f, box, 'inside', false);
%     figure('color','w'); view(3); axis equal
%     drawMesh(v, f, 'faceColor', 'none', 'faceAlpha', .2);
%     drawBox3d(box)
%     drawMesh(v2, f2, 'faceAlpha', .7);
%
%   See also
%   meshes3d, clipPoints3d
%

% ------
% Author: David Legland, oqilipo
% e-mail: david.legland@inra.fr
% Created: 2011-04-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% if input is given as a structure, parse fields
if isstruct(v)
    if nargin > 2
        varargin = [b, varargin]; 
    end
    b = f;
    f = v.faces;
    v = v.vertices;
end

parser = inputParser;
validStrings = {'box', 'sphere', 'plane'};
addParameter(parser, 'shape', 'box', @(x) any(validatestring(x, validStrings)));
addParameter(parser, 'inside', true, @islogical);
addParameter(parser, 'trimMesh', false, @islogical);
parse(parser, varargin{:});

% clip the vertices
[v2, indVertices] = clipPoints3d(v, b,...
    'shape', parser.Results.shape, 'inside', parser.Results.inside);

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

if parser.Results.trimMesh
    [v2, f2] = trimMesh(v2, f2);
end

varargout = formatMeshOutput(nargout, v2, f2);
