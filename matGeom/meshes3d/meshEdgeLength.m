function lengths = meshEdgeLength(varargin)
%MESHEDGELENGTH Lengths of edges of a polygonal or polyhedral mesh.
%
%   output = meshEdgeLength(V, E, F)
%
%   Example
%   meshEdgeLength
%
%   See also 
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2010-10-04, using Matlab 7.9.0.529 (R2009b)
% Copyright 2010-2023 INRA - Cepia Software Platform

% parse input arguments
[vertices, edges, faces] = parseMeshData(varargin{:});
if isempty(edges)
    edges = meshEdges(faces);
end

% extract vertices
p1 = vertices(edges(:, 1), :);
p2 = vertices(edges(:, 2), :);

% compute euclidean distance betwenn the two vertices
lengths = sqrt(sum((p2-p1).^2, 2));
