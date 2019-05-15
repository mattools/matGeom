function varargout = surfToMesh(x, y, varargin)
%SURFTOMESH Convert surface grids into face-vertex mesh.
%
%   [V F] = surfToMesh(X, Y)
%   [V F] = surfToMesh(X, Y, Z)
%   Converts the surface grid given by two or three coordinate arrays into
%   a face-vertex quad mesh.
%
%   Example
%     % transform a surface into a mesh
%     [X,Y] = meshgrid(-2:.2:2, -2:.2:2);                                
%     Z = X .* exp(-X.^2 - Y.^2);
%     [V F] = surfToMesh(X, Y, Z);
%     figure;
%     drawMesh(V, F); view(3);
%
%     % Transform surface of a cylinder as a mesh
%     [x y z] = cylinder(5*ones(1, 10));
%     [v f] = surfToMesh(x, y, z, 'xPeriodic', true);
%     figure;
%     drawMesh(v, f);
%     view(3); axis equal;
%
%   See also
%     meshes3d, meshgrid, drawMesh, torusMesh, sphereMesh

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-10-25,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.


%% Parse inputs

% check if z-value is present
if ~isempty(varargin) && isnumeric(varargin{1})
    z = varargin{1};
    varargin(1) = [];
end

% default periodicities
xPeriodic = false;
yPeriodic = false;

% parse input options
while length(varargin) > 1
    paramName = lower(varargin{1});
    switch paramName
        case 'xperiodic'
            xPeriodic = varargin{2};
        case 'yperiodic'
            yPeriodic = varargin{2};
        otherwise
            error(['Unknown parameter name: ' paramName]);
    end

    varargin(1:2) = [];
end



%% Compute vertex indices

% size along each direction (arrays are (y,x)-indexed)
n1 = size(x, 1);
n2 = size(x, 2);

% in case of periodicity, the last vertex of the grid is drop (it is
% assumed to be the same as the first one)
if xPeriodic
    n2 = n2 - 1;
end
if yPeriodic
    n1 = n1 - 1;
end

% new size of vertex grid
dim = [n1 n2];
nv = n1 * n2;


%% Create vertex array

% eventually remove boundary vertices
x = x(1:n1, 1:n2);
y = y(1:n1, 1:n2);

% create vertex array
if ~exist('z', 'var')
    vertices = [x(:) y(:)];
else
    z = z(1:n1, 1:n2);
    vertices = [x(:) y(:) z(:)];
end


%% Create face array

% vertex indices in grid
inds = reshape(1:nv, dim);
if xPeriodic
    inds = inds(:, [1:end 1]);
end
if yPeriodic
    inds = inds([1:end 1], :);
end

% vertex indices for each face
v1 = inds(1:end-1, 1:end-1);
v2 = inds(1:end-1, 2:end);
v3 = inds(2:end, 2:end);
v4 = inds(2:end, 1:end-1);

% concatenate indices
faces = [v1(:) v2(:) v3(:) v4(:)];


%% format output
varargout = formatMeshOutput(nargout, vertices, faces);
