function [refMesh, distListIters, refVerticesIters] = averageMesh(meshList, varargin)
% Compute average mesh from a list of meshes.
%
%   AVG = averageMesh(MESHLIST)
%
%   Example
%   averageMesh
%
%   See also
%     meshes3d
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-01-31,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRAE.


%% Parse input values

% default values
nIters = 10;
verbose = false;

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
refMesh = struct('vertices', meshList{1}.vertices, 'faces', meshList{1}.faces);

refVerticesIters = cell(1, nIters);
distListIters = cell(1, nIters);


%% Main iteration

for iIter = 1:nIters
    if verbose
        fprintf('iter %d/%d\n', iIter, nIters);
    end
    refMesh = smoothMesh(refMesh);
    
    % create new array for average vertices
    newVerts = zeros(size(refMesh.vertices));
    distList = zeros(size(refMesh.vertices, 1), 1);
    
    % iterate over all meshes
    for iMesh = 1:nMeshes
        if verbose
            fprintf('    mesh %d/%d\n', iMesh, nMeshes);
        end
        
%         mesh = meshList{iMesh};
        inds = knnsearch(treeList{iMesh}, refMesh.vertices); 

%         closest = mesh.vertices(inds,:);
        closest = treeList{iMesh}.X(inds,:);
        newVerts = newVerts + closest;
        distList = distList + sum((closest - refMesh.vertices).^2, 2);
    end

    % update new vertices
    newVerts = newVerts / nMeshes;
    refVerticesIters{iIter} = newVerts;
    refMesh.vertices = newVerts;
    
    % keep list of distances
    distList = sqrt(distList / nMeshes);
    distListIters{iIter} = distList;
end


% figure; drawMesh(refMesh, 'lineStyle', 'none', 'faceColor', [.5 .5 .5])
% axis equal; view(3); hold on; axis([-2.5 2.5 -2 2 -3.5 3.5]); light;
% lighting gouraud
% title('Average mesh');
% print(gcf, 'averageMesh_initial.png', '-dpng');

