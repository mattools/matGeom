function [germs, germPaths] = centroidalVoronoi2d_MC(germs, poly, varargin)
%CENTROIDALVORONOI2D_MC Centroidal Voronoi tesselation by Monte-Carlo
%
%   PTS = centroidalVoronoi2d_MC(NPTS, POLY)
%   Generate points in a polygon based on centroidal voronoi tesselation.
%   Centroidal germs can be computed by using the Llyod's algorithm:
%   1) initial germs are chosen at random within polygon
%   2) voronoi polygon of the germs is computed
%   3) the centroids of each domain are computed, and used as germs of the
%   next iteration
%
%   This version uses a Monte-Carlo version of Llyod's algorithm. The
%   centroids are not computed explicitly, but approximated by sampling N
%   points within the bounding polygon. 
%
%   [PTS, PATHLIST] = centroidalVoronoi2d_MC(NPTS, POLY)
%   Also returns the path of each germs at each iteration. The result
%   PATHLIST is a cell array with as many cells as the number of germs,
%   containing in each cell the successive positions of the germ.
%
%   PTS = centroidalVoronoi2d_MC(.., PARAM, VALUE)
%   Specify one or several optional arguments. PARAM can be one of:
%   * 'nIter'   specifies the number of iterations of the algorithm
%       (default is 50)
%   * 'nPoints' number of points for updating positions of germs at each
%       iteration. Default is 200 times the number of germs.
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
%   graphs, boundedVoronoi2d, centroidalVoronoi2d
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

% number of germs
if isscalar(germs)
    nGerms = germs;
    germs = [];
else
    nGerms = size(germs, 1);
end

% random point generator
% Should be either empty (-> use random generator) or be an instance of
% quasi-random sequence generator sucha as haltonset or sobolset.
generator = [];

% Number of points
nPts = 200 * nGerms;

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
        case 'npoints'
            nPts = varargin{2};
        case 'generator'
            generator = varargin{2};

            % ensure generator is a stream
            if isa(generator, 'qrandset')
                generator = qrandstream(generator);
            elseif isa(generator, 'qrandstream')
                % ok, nothing to do...
            else
                error('quasi-random generator is not properly specified');
            end
            
        otherwise
            error(['Unknown parameter name: ' paramName]);
    end

    varargin(1:2) = [];
end


%% Initialisations

% bounding box of polygon
box = polygonBounds(poly);

% init germs if needed
if isempty(germs)
    if isempty(generator)
        germs = generatePointsInPoly(nGerms);
    else
        germs = generateQRandPointsInPoly(nGerms);
    end
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
    
    % random uniform points in polygon
    if verbose
        disp('  generate points');
    end
    if isempty(generator)
        points = generatePointsInPoly(nPts);
    else
        points = generateQRandPointsInPoly(nPts);
    end
    
    % for each point, determines index of the closest germ
    if verbose
        disp('  find closest germ');
    end
    ind = zeros(nPts, 1);
    for iPoint = 1:nPts
        x0 = points(iPoint, 1);
        y0 = points(iPoint, 2);
        [tmp, ind(iPoint)] = min((germs(:,1)-x0).^2 + (germs(:,2)-y0).^2); %#ok<ASGLU>
    end

    % update the position of each germ
    if verbose
        disp('  update germ position');
    end
    for iGerm = 1:nGerms
        germs(iGerm,:) = centroid(points(ind == iGerm, :));
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
    xmin = box(1);  xmax = box(2);
    ymin = box(3);  ymax = box(4);
    
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

function pts = generateQRandPointsInPoly(nPts)
    % extreme coordinates
    xmin = box(1);  xmax = box(2);
    ymin = box(3);  ymax = box(4);
    
    % compute size of box
    dx = xmax - xmin;
    dy = ymax - ymin;
    
    % allocate memory for result
    pts = zeros(nPts, 2);

    % iterate until all points have been sampled within the polygon
    ind = (1:nPts)';
    while ~isempty(ind)
        NI = length(ind);
        pts0 = qrand(generator, NI);
        x = pts0(:, 1) * dx + xmin;
        y = pts0(:, 2) * dy + ymin;
        pts(ind, :) = [x y];
        
        ind = ind(~polygonContains(poly, pts(ind, :)));
    end
end

end

