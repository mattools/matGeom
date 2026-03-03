function varargout = drawMeshVertices(varargin)
%DRAWMESHVERTICES Draw the vertices of a 3D polygon mesh.
%
%   drawMeshVertices(MESH)
%   drawMeshVertices(V, F)
%   Draws the vertices of the given mesh, using pre-defined style.
%   Default is to draw vertices as black squares with white interior.
%
%   Example
%   drawMeshVertices
%
%   See also
%     drawMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2026-03-03,    using Matlab 25.1.0.2973910 (R2025a) Update 1
% Copyright 2026 INRAE.

%% Parse input arguments

% extract handle of axis to draw on
[ax, varargin] = parseAxisHandle(varargin{:});

% Check if the input is a mesh structure
var1 = varargin{1};
varargin(1) = [];
if isstruct(var1)
    % extract data to display
    vertices = var1.vertices;
else
    % assumes input is given with vertices+faces arrays
    vertices = var1;
    varargin(1) = [];
end

% if vertices are 2D points, add a z=0 coordinate
if size(vertices, 2) == 2
    vertices(1, 3) = 0;
end

% concatenate input argument(s) with default options
defaults = {'MarkerSize', 6, 'MarkerFaceColor', 'w'};
if isscalar(varargin)
    varargin = [varargin defaults];
else
    varargin = [{'ks'} defaults varargin];
end


%% Draw the vertices

% draw the vertices
h = plot3(ax, vertices(:,1), vertices(:,2), vertices(:,3), varargin{:});

% format output arg
if nargout > 0
    varargout = {h};
end
