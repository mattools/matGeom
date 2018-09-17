function varargout = boundedCentroidalVoronoi2d(germs, box, varargin)
%BOUNDEDCENTROIDALVORONOI2D Create a 2D Centroidal Voronoi Tesselation in a box
%
%   [N, E, F] = boundedCentroidalVoronoi2d(GERMS, BOX)
%   GERMS are N-by-2 point array, BOX is given as [xmin xmax ymin ymax].
%   Algorithm is an iteration of voronoi diagram computations, using at
%   each steps the centroids of previous diagram as germs for the new
%   diagram.
%
%   [N, E, F] = boundedCentroidalVoronoi2d(GERMS, BOX, NITER)
%   Specifies the number of iterations.
%
%   [N, E, F, G] = boundedCentroidalVoronoi2d(...)
%   also returns the positions of germs/centroids for each face. If the
%   number of iteration was sufficient, location of germs should correspond
%   to centroids of faces 'fc' computed using: 
%   fc(i,:) = polygonCentroid(n(f{i}, :));
%
%   Example
%   [n, e, f] = boundedCentroidalVoronoi2d(rand(20, 2)*100, [0 100 0 100]);
%   drawGraph(n, e, f);
%
%   See also
%     graphs, boundedVoronoi2d, centroidalVoronoi2d, clipGraph
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2007-01-12
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% HISTORY
% 27/07/2007 add doc, and psb to specify number of iterations
% 18/09/2007 add psb to return germs of tessellation
% 23/02/2012 rename from centroidalVoronoi2d to boundedCentroidalVoronoi2d

% number of iteration
nIter = 10;
if ~isempty(varargin)
    nIter = varargin{1};
end

% limits and size of the box
x0 = box(1); x1 = box(2);
y0 = box(3); y1 = box(4);
dx = x1 - x0;  dy = y1 - y0;

% far points to bound the voronoi diagram
farPoints = [...
    x1 + 10 * dx, y1 + 10 * dy;...
    x0 - 10 * dx, y1 + 10 * dy;...
    x0 - 10 * dx, y0 - 10 * dy;...
    x1 + 10 * dx, y0 - 10 * dy];

% iterate bounded voronoi tesselation
for i = 1:nIter
    % generate Voronoi diagram, and clip with the box
    [n, e, f] = voronoi2d([germs ; farPoints]);
    [n, e, f] = clipGraph(n, e, f, box);
    
    % centroid of each face will be used as germs for next iteration
    for j = 1:length(f)
        face = n(f{j}, :);
        germs(j, 1:2) = polygonCentroid(face);
    end
end

% result is given in n, e, and f, eventually germs
varargout{1} = n;
varargout{2} = e;
varargout{3} = f;
if nargout > 3
    varargout{4} = germs;
end
