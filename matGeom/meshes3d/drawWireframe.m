function varargout = drawWireframe(varargin)
%DRAWWIREFRAME Draw a mesh as a wireframe (only the edges).
%
%   drawWireframe(VERTICES, FACES)
%   drawWireframe(MESH)
%
%   Example
%   drawWireframe
%
%   See also
%     meshes3d, drawMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-02-26,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE.

%% Parse input arguments

% extract first argument
var1 = varargin{1};
varargin(1) = [];

% Check if first input argument is an axes handle
if isAxisHandle(var1)
    ax = var1;
    var1 = varargin{1};
    varargin(1) = [];
else
    ax = gca;
end

% retrieve vertices and faces data
if isstruct(var1)
    % mesh struct
    vertices = var1.vertices;
    faces = var1.faces;
else
    % assumes input is given with vertices+faces arrays
    vertices = var1;
    faces = varargin{1};
    varargin(1) = [];
end

if isempty(varargin)
     % default edges as black lines by default
    varargin = {'linestyle', '-', 'EdgeColor', 'k'};
end


%% Draw edges of the mesh

% overwrite on current figure
hold(ax, 'on');

% use 'patch' command for fast display
h = patch('vertices', vertices, 'faces', faces, ...
    'FaceColor', 'none', ...
    varargin{:});


%% Process output arguments

% format output parameters
if nargout > 0
    varargout = {h};
end
