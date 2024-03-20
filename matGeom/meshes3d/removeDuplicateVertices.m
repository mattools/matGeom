function varargout = removeDuplicateVertices(v,varargin)
%REMOVEDUPLICATEVERTICES Remove duplicate vertices of a mesh.
%
%   [V2, F2] = removeDuplicateVertices(V, F) 
%   Remove duplicate vertices of a mesh defined by the vertices V and 
%   faces F.
%
%   [V2, F2] = removeDuplicateVertices(V, F, TOL)
%   Remove duplicate vertices with the tolerance TOL:
%       TOL = 0     -> Exact match
%       TOL = 1e-1  -> Match up to first decimal
%       TOL = 1     -> Integer match
%
%   [VIDX, FIDX] = removeDuplicateVertices(V, F, TOL, 'indexOutput', true)
%   Gives the indices instead of the final mesh. This means:
%       V2 = V(VIDX,:)
%       F2 = FIDX(F)
%       V = V2(FIDX,:)
%
%   Example
%     v = [6-1e-6,0,-5;4,2,-2*pi;0,2,-7;6,0,-5;3,1,-9;0,2,-7;...
%         6,0,-5+1e-6;4,2,-2*pi;3,1,-9;4,2,-2*pi;6,4,-6;3,1,-9;...
%         4,2,-2*pi;0,2,-7;6,4,-6;6,4,-6;0,2,-7;3,1,-9];
%     f = reshape(1:18,3,6)';
%     [v, f] = removeDuplicateVertices(v, f);
%   
%   See also 
%     trimMesh, removeDuplicateFaces, removeUnreferencedVertices
%
%   Source
%     patchslim.m by Francis Esmonde-White:
%       https://mathworks.com/matlabcentral/fileexchange/29986
%     remove_duplicate_vertices.m by Alec Jacobson:
%       https://github.com/alecjacobson/gptoolbox

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-05-14, using Matlab 9.13.0.2080170 (R2022b) Update 1
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
addOptional(parser, 'tol', 0, @(x) validateattributes(x, {'numeric'}, {'scalar', '>=',0, '<=',1}));
addParameter(parser, 'indexOutput', false, logParValidFunc);
parse(parser, varargin{:});
tol = parser.Results.tol;
indexOutput = parser.Results.indexOutput;

%% Remove duplicate vertices
if tol == 0
    [~, vIdx, fIdx] = unique(v,'rows','stable');
else
    [~, vIdx, fIdx] = unique(round(v/(tol)),'rows','stable');
end

%% Parse output
if indexOutput
    % If indices are requested
    varargout = {vIdx, fIdx};
else
    % Output is the final mesh
    v2 = v(vIdx,:);
    f2 = fIdx(f);
    varargout = formatMeshOutput(nargout, v2, f2);
end

end
