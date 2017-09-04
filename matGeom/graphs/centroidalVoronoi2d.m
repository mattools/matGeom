function [germs, germPaths] = centroidalVoronoi2d(germs, poly, varargin)
%CENTROIDALVORONOI2D Centroidal Voronoi tesselation within a polygon
%
%   PTS = centroidalVoronoi2d(NPTS, POLY)
%   Generate points in a polygon based on centroidal voronoi tesselation.
%   Centroidal germs can be computed by using the Llyod's algorithm:
%   1) initial germs are chosen at random within polygon
%   2) voronoi polygon of the germs is computed
%   3) the centroids of each domain are computed, and used as germs of the
%   next iteration
%
%   [PTS, PATHLIST] = centroidalVoronoi2d(NPTS, POLY)
%   Also returns the path of each germs at each iteration. The result
%   PATHLIST is a cell array with as many cells as the number of germs,
%   containing in each cell the successive positions of the germ.
%
%   PTS = centroidalVoronoi2d(.., PARAM, VALUE)
%   Specify one or several optional arguments. PARAM can be one of:
%   * 'nIter'   specifies the number of iterations of the algorithm
%       (default is 50)
%   * 'verbose' display iteration number. Default is false.
%
%   Example
%     poly = ellipseToPolygon([50 50 40 30 20], 200);
%     nGerms = 100;
%     germs = centroidalVoronoi2d(nGerms, poly);
%     figure; hold on;
%     drawPolygon(poly, 'k');
%     drawPoint(germs, 'bo');
%     axis equal; axis([0 100 10 90]);
%     % extract regions of the CVD
%     box = polygonBounds(poly);
%     [n, e] = boundedVoronoi2d(box, germs);
%     [n2, e2] = clipGraphPolygon(n, e, poly);
%     drawGraphEdges(n2, e2, 'b');
%
%   See also
%   graphs, boundedVoronoi2d, centroidalVoronoi2d_MC
%
%   Rewritten from programs found in
%   http://people.scs.fsu.edu/~burkardt/m_src/cvt/cvt.html
%
%   Reference:
%    Qiang Du, Vance Faber, and Max Gunzburger,
%    Centroidal Voronoi Tessellations: Applications and Algorithms,
%    SIAM Review, Volume 41, 1999, pages 637-676.
%

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2012-02-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Parse input arguments

% Number of germs
if isscalar(germs)
    nGerms = germs;
    germs = [];
else
    nGerms = size(germs, 1);
end

% Number of iterations
nIter = 50;

verbose = false;

keepPaths = nargout > 1;

while length(varargin) > 1
    paramName = varargin{1};
    switch lower(paramName)
        case 'verbose'
            verbose = varargin{2};
        case 'niter'
            nIter = varargin{2};
            
        otherwise
            error(['Unknown parameter name: ' paramName]);
    end

    varargin(1:2) = [];
end


%% Initialisations

% bounding box of polygon
bbox = polygonBounds(poly);

% init germs if needed
if isempty(germs)
    germs = generatePointsInPoly(nGerms);
end
germIters = cell(nIter, 1);


%% Iteration of the Lloyd algorithm

for i = 1:nIter
     if verbose
        disp(sprintf('Iteration: %d/%d', i, nIter)); %#ok<DSPS>
    end
    
    if keepPaths
        germIters{i} = germs;
    end
    
    % Compute Clipped Voronoi diagram of germs
    if verbose
        disp('  compute Voronoi Diagram');
    end
    [n, e, f] = boundedVoronoi2d(bbox, germs);
    [n2, e2, f2] = clipMesh2dPolygon(n, e, f, poly); %#ok<ASGLU>

    % update the position of each germ
    if verbose
        disp('  compute centroids');
    end
    for iGerm = 1:nGerms
        polygon = n2(f2{iGerm}, :);
        germs(iGerm,:) = polygonCentroid(polygon);
    end
    
end


%% Evenutally compute germs trajectories

if nargout > 1
    % init
    germPaths = cell(nGerms, 1);
    path = zeros(nIter+1, 2);
    
    % Iteration on germs
    for i = 1:nGerms
        
        % create path corresponding to germ
        for j = 1:nIter
            pts = germIters{j};
            path(j,:) = pts(i,:);
        end
        path(nIter+1, :) = germs(i,:);
        
        germPaths{i} = path;
    end
end

function pts = generatePointsInPoly(nPts)
    % extreme coordinates
    xmin = bbox(1);  xmax = bbox(2);
    ymin = bbox(3);  ymax = bbox(4);
    
    % compute size of box
    dx = xmax - xmin;
    dy = ymax - ymin;
    
    % allocate memory for result
    pts = zeros(nPts, 2);

    % iterate until all points have been sampled within the polygon
    ind = (1:nPts)';
    while ~isempty(ind)
        NI = length(ind);
        x = rand(NI, 1) * dx + xmin;
        y = rand(NI, 1) * dy + ymin;
        pts(ind, :) = [x y];
        
        ind = ind(~polygonContains(poly, pts(ind, :)));
    end
end

end

