function [transfo, pt, ER, t] = registerPoints3d_icp(p, q, varargin)
%REGISTERPOINTS3D_ICP Computes rigid transform between two 3D point sets.
%
%   TRANSFO = registerPoints3d_icp(SOURCE, TARGET)
%   Computes the 3D rigid transform (composed of a rotation and a
%   translation) that maps the shape defined by the SOURCE points onto the
%   shape defined by the the TARGET points, using the "Iterated Closest
%   Point" (ICP) algorithm. 
%   Both SOURCE and TARGET are N-by-3 numeric arrays representing point
%   coordinates, not necessarily the same size. 
%   The result TRANSFO is a 4-by-4 matrix representing the final affine
%   transform.  
%
%   TRANSFO = registerPoints3d_icp(SOURCE, TARGET, NITERS)
%   Specifies the number of iterations of the algorithm (default is 10).
%
%   [TRANSFO, RES] = registerPoints3d_icp(...)
%   Also returns the result of the transform applied to SOURCE points.
%
%   [TRANSFO, RES, ER] = registerPoints3d_icp(...)
%   Also returns the error according to the iteration, as a NITERS+1 array
%   of numeric values.
%
%   [TRANSFO, RES, ER, T] = registerPoints3d_icp(...)
%   Also returns the time spent for each iteration, as a NITERS+1 array
%   of numeric values. T(1) corresponds to initialization time, T(end)
%   corresponds to the total processing time
%
%   [...] = registerPoints3d_icp(..., PNAME, PVALUE)
%   Specifies additional optional arguments are parameter name-value pairs.
%   Supported parameter names are:
%   * 'Matching'    The point matching method. Can be one of 'naive'
%       (the slowest), 'delaunay' (use a Delaunay diagram to reduce
%       computations) or 'kdTree' (use a kd-Tree data structure. This is
%       usually the fastest, but requires the Statistics Toolbox).
%
%
%   Example
%   registerPoints3d_icp
%
%   See also 
%     transforms3d, registerPoints3dAffine, pcregistericp
%
% Rewritten from the "icp" function, by Martin Kjer and Jakob Wilm,
% Technical University of Denmark, 2012.
% Notable differences:
% * SOURCE and TARGET input arrays are given as N-by-3 arrays (using the
%   general MatGeom convention) rather than 3-by-N arrays.
% * The resulting transform is packed into a single 4-by-4 array,
%   representing the affine transfom matrix in homogeneous coordinates.
% * All the options available in the original file are not managed in this
%   port.
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2023-05-30, using Matlab 9.14.0.2206163 (R2023a)
% Copyright 2023-2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

%% Parse input arguments
% parse input arguments using an instance of InputParser class

parser = inputParser;

% require source and target points sets, as N-by-3 and M-by-3 numeric arrays 
parser.addRequired('p', @(x) isreal(x) && size(x,2) == 3);
parser.addRequired('q', @(x) isreal(x) && size(x,2) == 3);

% optional number of iterations, default is 10.
parser.addOptional('nIters', 10, @ (x) x > 0 && x < 10^5);

% parse parameters as name-value pairs.

% the algorithm to match transformed source to target
validMatching = {'bruteForce', 'Delaunay', 'kDtree'};
parser.addParameter('Matching', 'bruteForce', @(x) any(strcmpi(x, validMatching)));

% the criterium to minimize
validMinimize = {'point', 'plane', 'lmapoint'};
parser.addParameter('Minimize', 'point', @(x) any(strcmpi(x,validMinimize)));

% the normals computed for each point of the target cloud (used for plane
% minimization)
parser.addParameter('Normals', [], @(x) isreal(x) && size(x,2) == 3);

parser.addParameter('NormalsData', [], @(x) isreal(x) && size(x,2) == 3);

% should the function returns the list of transforms (one for each iter)
parser.addParameter('ReturnAll', false, @(x) islogical(x));

% If Delaunay matching is used, the triangulation can be pre-computed
parser.addParameter('Triangulation', [], @(x) isreal(x) && size(x,2) == 3);

% Verbosity option
parser.addParameter('Verbose', false, @(x) islogical(x));

% Weights associated to the points
parser.addParameter('Weight', @(x) ones(length(x),1), @(x) isa(x,'function_handle'));

parser.addParameter('WorstRejection', 0, @(x) isscalar(x) && x > 0 && x < 1);

parser.parse(p, q, varargin{:});
args = parser.Results;


%% Initialisations

% Start timer
tic;

% number of iterations
nIters = args.nIters;

% transformed point set
% initialized to initial point clouds, but will correspond to transformed
% cloud during subsequent iterations
pt = p;

% allocate array for timing and RMS error at every iteration
t = zeros(nIters+1,1); 
ER = zeros(nIters+1, 1); 

% Initialize total transform vector(s) and rotation matric(es).
TT = zeros(1, 3, nIters+1);
TR = repmat(eye(3,3), [1,1, nIters+1]);
transfo = eye(4);
transfoList = cell(nIters+1, 1);
transfoList{1} = transfo;
    
% perform pre-processing depending on matching method    
if strcmpi(args.Matching, 'Delaunay')
    % If Matching == 'Delaunay', a triangulation is needed
    DT = delaunayTriangulation(q);

elseif strcmpi(args.Matching, 'kDtree')
    % If Matching == 'kDtree', a kD tree should be built
    % (requires Statistics Toolbox >= 7.3)
    kdTree = KDTreeSearcher(q);
end

% in case plane minimizer is used, check Normals" data exist
if strcmpi(args.Minimize, 'plane') && isempty(args.Normals)
    args.Normals = estimateVertexNormals(q, 4);
end

t(1) = toc;


%% Main loop

for iIter = 1:nIters
       
    % Identify the points in Q that match the points in P.
    % Each function returns an array with as many rows as the number of
    % source points, containing the index of the closest target point, 
    % and the distance between each pair of points.
    switch lower(args.Matching)
        case lower('bruteForce')
            [matchInds, mindist] = matchPoints_naive(pt, q);
        case lower('Delaunay')
            [matchInds, mindist] = matchPoints_Delaunay(pt, DT);
        case lower('kDtree')
            [matchInds, mindist] = matchPoints_kDtree(pt, kdTree);
        otherwise
            error('Unknown option for point matching: %s', args.Matching);
    end

    if iIter == 1
        ER(iIter) = rms(mindist);
    end
    
    % Identify the rotation and translation parts of the motion transform.
    % Each function should return two output arguments:
    % R as a 3-by-3 matrix representing the (vectorial) 3D rotation
    % T as a 1-by-3 row vector representing the translation vector
    switch lower(args.Minimize)
        case 'point'
            % Determine weight vector
            weights = args.Weight(matchInds);
            [R,T] = eq_point(q(matchInds, :), pt, weights);

        case 'plane'
            normals = args.Normals(matchInds,:);
            weights = args.Weight(matchInds);
            [R,T] = eq_plane(q(matchInds,:), pt, normals, weights);

        case lower('lmaPoint')
            [R,T] = eq_lmaPoint(q(matchInds,:), pt);

        otherwise
            error('Unknown option for Minimizer: %s', args.Minimize);
    end

    % update the concatenated transform
    TR(:,:,iIter+1) = R * TR(:,:,iIter);
    TT(:,:,iIter+1) = TT(:,:,iIter)*R' + T;
    transfo = [R T' ; 0 0 0 1];
    transfoList{iIter+1} = transfo * transfoList{iIter};

    % apply last transform to source points
    pt = transformPoint3d(p, transfoList{iIter+1});
    
    % root mean of objective function 
    ER(iIter+1) = rmse(pt, q(matchInds, :));
    
    t(iIter+1) = toc;
end

transfo = transfoList{end};


%% Utility functions

function [inds, minDist] = matchPoints_naive(p, q)

% retrieve number of points
n = size(p, 1);

% allocate memory
inds = zeros(n, 1);
minDist = zeros(n, 1);

% iterate over points to match
for i = 1:n
    dists = sum((q - p(i,:)).^2, 2);
    [minDist(i), inds(i)] = min(dists);
end

minDist = sqrt(minDist);

%%
function [inds, minDist] = matchPoints_Delaunay(p, DT)

inds = nearestNeighbor(DT, p);
minDist = sqrt(sum((p - DT.Points(inds,:)).^2, 1));

%%
function [inds, minDist] = matchPoints_kDtree(p, kdTree)

[inds, minDist] = knnsearch(kdTree, p);

%%
function [R, T] = eq_point(q, p, weights)

% retrieve size of data points
m = size(p, 1);
n = size(q, 1);

% normalize weights
weights = weights ./ sum(weights);

% find data centroid and deviations from centroid
q_bar = weights' * q;
q_mark = q - repmat(q_bar, n, 1);

% find data centroid and deviations from centroid
p_bar = weights' * p;
p_mark = p - repmat(p_bar, m, 1);

% Apply weights (need to apply to only one of the sets)
p_mark = p_mark .* repmat(weights, 1, 3);

% compute singular value decomposition
N = p_mark' * q_mark;
[U, ~, V] = svd(N);

% retrieve rotation and translation parts
R = V*diag([1 1 det(U*V')]) * U';
T = q_bar - p_bar * R';


%%
function [R, T] = eq_plane(q, p, n, weights)

n = n .* repmat(weights, 1, 3);

c = cross(p, n, 2);

cn = horzcat(c, n);

C = cn' * cn;

b = - [sum(sum((p-q).*repmat(cn(:,1),1,3).*n));
       sum(sum((p-q).*repmat(cn(:,2),1,3).*n));
       sum(sum((p-q).*repmat(cn(:,3),1,3).*n));
       sum(sum((p-q).*repmat(cn(:,4),1,3).*n));
       sum(sum((p-q).*repmat(cn(:,5),1,3).*n));
       sum(sum((p-q).*repmat(cn(:,6),1,3).*n))];
   
X = C\b;

cx = cos(X(1)); cy = cos(X(2)); cz = cos(X(3)); 
sx = sin(X(1)); sy = sin(X(2)); sz = sin(X(3)); 

R = [cy*cz cz*sx*sy-cx*sz cx*cz*sy+sx*sz;
     cy*sz cx*cz+sx*sy*sz cx*sy*sz-cz*sx;
     -sy cy*sx cx*cy];
    
T = X(4:6)';


%%
function [R, T] = eq_lmaPoint(q, p)
% Fit Rotation and Translation using Levenberg-Marquard minimization.

% create the Rotation anonymous function for transforming points
Rx = @(a)[1     0       0;
          0     cos(a)  -sin(a);
          0     sin(a)  cos(a)];
Ry = @(b)[cos(b)    0   sin(b);
          0         1   0;
          -sin(b)   0   cos(b)];
Rz = @(g)[cos(g)    -sin(g) 0;
          sin(g)    cos(g)  0;
          0         0       1];
Rot = @(x) Rx(x(1)) * Ry(x(2)) * Rz(x(3));

% anonymous function of the transform vector that transform the points
myfun = @(x,xdata) xdata * Rot(x(1:3))' + repmat(x(4:6),length(xdata),1);
% myfun = @(x,xdata)Rot(x(1:3))*xdata+repmat(x(4:6),1,length(xdata));

% minimizes the quantity: 'myfun(x,p) - q'
options = optimset('Algorithm', 'levenberg-marquardt');
x = lsqcurvefit(myfun, zeros(1,6), p, q, [], [], options);

R = Rot(x(1:3));
T = x(4:6);


%%
function ER = rmse(p1, p2)
% Determine the RMS error between two point equally sized point clouds with
% point correspondance.
% ER = rmse(p1,p2) where p1 and p2 are n-by-3 numeric arrays.

sqDist = sum((p1 - p2).^2, 2);
ER = sqrt(mean(sqDist));


%%
function n = estimateVertexNormals(p, k)
% Least squares normal estimation from point clouds using PCA.
%
%   P: input vertices, as a M-by-3 numeric array
%   K: number of neighbrs to consider for computing PCA
%
% Ref:
% H. Hoppe, T. DeRose, T. Duchamp, J. McDonald, and W. Stuetzle. 
% Surface reconstruction from unorganized points. 
% In Proceedings of ACM Siggraph, pages 71:78, 1992.
%
% Requires the Statistics Toolbox

m = size(p,1);
n = zeros(m,3);

% for each point, find its (k+1) nearest neighbor
% (add 1 because each point is counted within its neighbors)
neighbors = knnsearch(p, p, 'k', k+1);

for i = 1:m
    % retrieve neighbors of current point
    x = p(neighbors(i, 2:end), :);

    % build the variance-covariance matrix to diagonalize
    p_bar = mean(x);
    P = (x - p_bar)' * (x - p_bar);
    
    % perform SVD
    [V, D] = eig(P);
    
    % choose the smallest eigenvalue
    [~, idx] = min(diag(D));
    
    % return the corresponding eigenvector
    n(i,:) = V(:,idx)';
end
