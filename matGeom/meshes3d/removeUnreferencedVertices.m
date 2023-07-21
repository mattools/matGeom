function varargout = removeUnreferencedVertices(v, varargin)
%REMOVEUNREFERENCEDVERTICES Remove unreferenced vertices of a mesh.
%
%   [V2, F2] = removeUnreferencedVertices(V, F)
%   Remove unreferenced/unindexed vertices of a mesh defined by the
%   vertices V and faces F.
%
%   [VIDX, FIDX] = removeUnreferencedVertices(V, F, 'indexOutput', true)
%   Gives the indices instead of the final mesh. This means:
%       V2 = V(VIDX,:)
%       F2 = FIDX(F)
%
%   Example:
%     [v, f] = createCube;
%     % Add unreferenced vertices
%     for idx = [2, 5, 7]
%         v = [v(1:idx,:); rand(1,3); v(idx+1:end,:)];
%         f(find(f>idx))=f(find(f>idx))+1; %#ok<FNDSB> 
%     end
%     [v2, f2] = removeUnreferencedVertices(v, f);
%
%   See also 
%     trimMesh, removeDuplicateFaces, removeDuplicateVertices
%
%   Source
%     remove_unreferenced.m by Alec Jacobson:
%       https://github.com/alecjacobson/gptoolbox

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-07-14, using Matlab 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023

%% Parse input
if isstruct(v)
    [v, f] = parseMeshData(v);
else
    f = varargin{1};
    varargin(1) = [];
end

parser = inputParser;
logParValidFunc = @(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addParameter(parser, 'indexOutput', false, logParValidFunc);
parse(parser, varargin{:});
indexOutput = parser.Results.indexOutput;

%% Remove unreferenced/unindexed vertices
if isempty(f)
    [vIdx, fIdx] = deal([]);
else
    % Get list of unique vertex indices that occur in faces
    sF = sort(f(:));
    I = [true;diff(sF)~=0];
    U = sF(I);
    % Get list of vertices that do not occur in faces
    n = size(v,1);
    NU = find(0==sparse(U,1,1,n,1));
    % assert((size(U,1) + size(NU,1)) == n);
    % Allocate space for an indexmap
    fIdx = zeros(n,1);
    % Reindex vertices that occur in faces to be first
    fIdx(U) = 1:size(U,1);
    % Reindex vertices that do not occur in faces to come after those that do
    fIdx(NU) = size(U,1) + (1:size(NU,1));
    % New vertices
    vIdx = ismember(1:length(v),U);
    % v2(fIdx,:) = v;
    % v2 = v2(1:max(fIdx(f(:))),:);
end

%% Parse output
if indexOutput
    % If indices are requested
    varargout = {vIdx, fIdx};
else
    v2 = v(vIdx,:);
    f2 = fIdx(f);
    varargout = formatMeshOutput(nargout, v2, f2);
end

end
