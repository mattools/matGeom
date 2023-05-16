function varargout = removeDuplicateVertices(v,varargin)
% REMOVEDUPLICATEVERTICES Remove duplicate vertices of a mesh
%
%   [V, F] = removeDuplicateVertices(V, F) 
%   Remove duplicate vertices of a mesh defined by the vertices V and faces
%   F.
%
%   [V, F] = removeDuplicateVertices(V, F, TOL)
%   Remove duplicate vertices with the tolerance TOL:
%       TOL = 0     -> Exact match
%       TOL = 1e-1  -> Match up to first decimal
%       TOL = 1     -> Integer match
%
%   Example:
%     v = [6-1e-6,0,-5;4,2,-2*pi;0,2,-7;6,0,-5;3,1,-9;0,2,-7;...
%         6,0,-5+1e-6;4,2,-2*pi;3,1,-9;4,2,-2*pi;6,4,-6;3,1,-9;...
%         4,2,-2*pi;0,2,-7;6,4,-6;6,4,-6;0,2,-7;3,1,-9];
%     f = reshape(1:18,3,6)';
%     [v, f] = removeDuplicateVertices(v, f);
%   
%   See also 
%     trimMesh, removeDuplicateFaces
%
%   Source:
%     patchslim.m by Francis Esmonde-White:
%       https://mathworks.com/matlabcentral/fileexchange/29986
%     remove_duplicate_vertices.m by Alec Jacobson:
%       https://github.com/alecjacobson/gptoolbox

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-05-14, using Matlab 9.13.0.2080170 (R2022b) Update 1
% Copyright 2021-2023


%% Parse input
if isstruct(v)
    [v, f] = parseMeshData(v);
else
    f = varargin{1};
    varargin(1) = [];
end

parser = inputParser;
addOptional(parser, 'tol', 0, @(x) validateattributes(x, {'numeric'}, {'scalar', '>=',0, '<=',1}));
parse(parser, varargin{:});
tol = parser.Results.tol;

%% Remove duplicate vertices
if tol == 0
    [~, vIdx, v2Idx] = unique(v,'rows','stable');
else
    [~, vIdx, v2Idx] = unique(round(v/(tol)),'rows','stable');
end
v2 = v(vIdx,:);

f2 = reshape(v2Idx(f),size(f));

%% Parse output
varargout = formatMeshOutput(nargout, v2, f2);

end