function edges = polygonEdges(poly)
%POLYGONEDGES Return the edges of a simple or multiple polygon
%
%   EDGES = polygonEdges(POLY)
%   Return the set of edges of the polygon specified by POLY. POLY may be
%   either a simple polygon given as a N-by-2 array of vertices, or a
%   multiple polygon given by a cell array of linear rings, each ring being
%   given as N-by-2 array of vertices.
%
%
%   Example
%     poly = [50 10;60 10;60 20;50 20];
%     polygonEdges(poly)
%     ans =
%         50    10    60    10
%         60    10    60    20
%         60    20    50    20
%         50    20    50    10
%
%   See also
%     polygons2d
 
% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2017-08-29,    using Matlab 9.1.0.441655 (R2016b)
% Copyright 2017 INRA - Cepia Software Platform.

% test presence of NaN values
if isnumeric(poly) && any(isnan(poly(:)))
    poly = splitPolygons(poly);
end

% create the array of polygon edges
if iscell(poly)
    % process multiple polygons
    edges = zeros(0, 4);
    for i = 1:length(poly)
        pol = poly{i};
        N = size(pol, 1);
        edges = [edges; pol(1:N, :) pol([2:N 1], :)]; %#ok<AGROW>
    end
else
    % get edges of a simple polygon
    N = size(poly, 1);
    edges = [poly(1:N, :) poly([2:N 1], :)];
end