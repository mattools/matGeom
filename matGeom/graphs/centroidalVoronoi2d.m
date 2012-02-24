function [germs germPaths] = centroidalVoronoi2d(nGerms, poly, varargin)
%CENTROIDALVORONOI2D Centroidal Voronoi tesselation within a polygon
%
%   PTS = centroidalVoronoi2d(NPTS, POLY)
%   Generate points in a polygon based on centroidal voronoi tesselation.
%   Centroidal germs can be computed by using the Llyod's algorithm:
%   1) initial germs are chosen at random within polygon
%   2) voronoi polygon of the germs is computed
%   3) the centroid of each domain are computed, and used as germs of the
%   next iteration
%
%   This version uses an approximated version of Llyod's algorithm. The
%   centroids are not computed explicitly, but approximated by sampling N
%   points within the bounding polygon. 
%
%   PTS = centroidalVoronoi2d(.., PARAM, VALUE)
%   Specify one or several optional arguments. PARAM can be one of:
%   * 'nIter'   specifies the number of iterations of the algorithm
%       (default is 30)
%   * 'nPoints' number of points for updating positions of germs at each
%       iteration. Default is 200 times the number of germs.
%   * 'verbose' display iteration number. Default is false.
%
%   Example
%   centroidalVoronoi2d
%
%   See also
%   graphs, boundedVoronoi2d
%
%   Rewritten from programs found in
%   http://people.scs.fsu.edu/~burkardt/m_src/cvt/cvt.html
%
%  Reference:
%    Qiang Du, Vance Faber, and Max Gunzburger,
%    Centroidal Voronoi Tessellations: Applications and Algorithms,
%    SIAM Review, Volume 41, 1999, pages 637-676.
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

%% Parse input arguments

% Number of points
nPts = 200 * nGerms;

% Number of iterations
nIter = 30;

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
        otherwise
            error(['Unknown parameter name: ' paramName]);
    end

    varargin(1:2) = [];
end


%% Initialisations

% bounding box of polygon
box = polygonBounds(poly);

% init germs
germs = generatePointsInPoly(nGerms);

germIters = cell(nIter, 1);


%% Iteration of the McQueen algorithm

for i = 1:nIter
    if verbose
        disp(sprintf('Iteration: %d/%d', i, nIter)); %#ok<DSPS>
    end
    
    if keepPaths
        germIters{i} = germs;
    end
    
    % random uniform points in polygon
    points = generatePointsInPoly(nPts);
    
    % update germs of Voronoi
    germs = cvtUpdate(germs, points);
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

end

