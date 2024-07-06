function [avgMesh, distsIters, verticesIters] = averageMesh(meshList, varargin)
%AVERAGEMESH Compute average mesh from a list of meshes.
%
%   AVGMESH = averageMesh(MESHLIST)
%   Where MESHLIST is a cell array of meshes, computes an average mesh that
%   minimizes the sum of squared distances between average mesh vertices
%   and all other mesh vertices.
%   The method is to choose an arbitrary reference mesh, and to iterate a
%   series of smoothin of the reference mesh, computation of nearest vertex
%   neighbors, and computing average position of nearest neighbors.
%
%   [AVGMESH, DISTS] = averageMesh(MESHLIST)
%   Returns also a cell array containing for each iteration, the standard
%   deviation of distances to other individual meshes.
%
%   [AVGMESH, DISTS, VERT_ITERS] = averageMesh(MESHLIST)
%   Also returns for each iteration, the positions of the average vertices.
%
%   [AVGMESH, DISTS] = averageMesh(..., PNAME, PVALUE)
%   Provides addition options are parameter name-value pairs. Available
%   options are:
%   * verbose: (logical, default false) display or not information about
%       process
%   * nIters: number of smooth-projection iterations to perform. Default
%       value is 10.
%   * smoothingIteration: the number of smoothing operations to apply on
%       average mesh at each iteration. Default value is 3.
%
%
%   Example
%   averageMesh
%
%   See also 
%     meshes3d, smoothMesh

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2020-01-31, using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020-2024 INRAE - BIA Research Unit - BIBS Platform (Nantes)

%% Parse input values

% default values
nIters = 10;
verbose = false;
smoothingIterations = 3;

% parse input arguments
while length(varargin) > 1
    name = varargin{1};
    if ~ischar(name)
        error('require parameter name-value pairs');
    end
    
    if strcmpi(name, 'verbose')
        verbose = varargin{2};
    elseif strcmpi(name, 'nIters')
        nIters = varargin{2};
    elseif strcmpi(name, 'smoothingIterations')
        smoothingIterations = varargin{2};
    else
        error(['Unknown parameter name: ' name]);
    end
    varargin(1:2) = [];
end


%% Initialisations

nMeshes = length(meshList);

% initialize kd-trees to accelerate nearest-neighbor searches
treeList = cell(nMeshes, 1);
for iMesh = 1:nMeshes
    treeList{iMesh} = KDTreeSearcher(meshList{iMesh}.vertices);
end

% choose arbitrary initial mesh
avgMesh = struct('vertices', meshList{1}.vertices, 'faces', meshList{1}.faces);

verticesIters = cell(1, nIters);
distsIters = cell(1, nIters);


%% Main iteration

% iterates smoothing + computation of average projections
for iIter = 1:nIters
    if verbose
        fprintf('iter %d/%d\n', iIter, nIters);
    end
    % apply smoothing to current average mesh
    avgMesh = smoothMesh(avgMesh, smoothingIterations);
    
    % create new array for average vertices
    newVerts = zeros(size(avgMesh.vertices));
    dists = zeros(size(avgMesh.vertices, 1), 1);
    
    % iterate over all meshes
    for iMesh = 1:nMeshes
        if verbose
            fprintf('    mesh %d/%d\n', iMesh, nMeshes);
        end
        
        % for each vertex of reference mesh, find index of closest vertex
        % in current mesh
        inds = knnsearch(treeList{iMesh}, avgMesh.vertices); 
        
        % keep position of closest vertex to update new position
        closest = treeList{iMesh}.X(inds,:);
        newVerts = newVerts + closest;

        % keep distance to closest index to build variability map
        dists = dists + sum((closest - avgMesh.vertices).^2, 2);
    end

    % update position of new vertices
    newVerts = newVerts / nMeshes;
    verticesIters{iIter} = newVerts;
    avgMesh.vertices = newVerts;
    
    % keep list of distances
    dists = sqrt(dists / nMeshes);
    distsIters{iIter} = dists;
end


% figure; drawMesh(refMesh, 'lineStyle', 'none', 'faceColor', [.5 .5 .5])
% axis equal; view(3); hold on; axis([-2.5 2.5 -2 2 -3.5 3.5]); light;
% lighting gouraud
% title('Average mesh');
% print(gcf, 'averageMesh_initial.png', '-dpng');

