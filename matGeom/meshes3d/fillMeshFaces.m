function varargout = fillMeshFaces(varargin)
% Fill the faces of a mesh with the specified colors.
%
%   fillMeshFaces(V, F, VERTEXCOLORS)
%   Colorizes a mesh by filling faces with an array of values. The colors
%   can be a NV-by-1 array of values, or a NV-by-3 array of values.
%   Face filling uses 'interp' coloring mode.
%
%   fillMeshFaces(V, F, FACECOLORS)
%   Colorizes the mesh by specifying the value or the color associated to
%   each face. Face filling uses 'flat' coloring mode.
%
%   fillMeshFaces(..., PNAME, PVALUE)
%   Specifies additional parameters that will be passed to the 'patch'
%   function.
%
%   Example
%     % Colorize mesh based on z-coordinate of vertices.
%     [v, f] = createIcosahedron;
%     values = v(:,3);
%     figure; axis equal; view(3);
%     fillMeshFaces(v, f, values);
%
%     % Colorize mesh using specific color for each face
%     [v, f] = createIcosahedron;
%     colors = jet(20);
%     figure; axis equal; view(3);
%     fillMeshFaces(v, f, colors);
%
%   See also
%     drawMesh
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-04-16,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRAE.

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

% Check if the input is a mesh structure
if isstruct(var1)
    % extract data to display
    vertices = var1.vertices;
    faces = var1.faces;
else
    % assumes input is given with vertices+faces arrays
    vertices = var1;
    faces = varargin{1};
    varargin(1) = [];
end

% next argument is face color
colors = varargin{1};
varargin(1) = [];

% adapt the face color key value depending on the size of the "color" input
% argument
faceColorMode = 'interp';
if size(colors, 1) == size(faces, 1)
    faceColorMode = 'flat';
end

% array FACES is a NF-by-NV indices array, with NV number of vertices of
% each face, and NF number of faces
h = patch('Parent', ax, ...
    'vertices', vertices, 'faces', faces, 'FaceVertexCData', colors, ...
    'FaceColor', faceColorMode, varargin{:});


%% Process output arguments

% format output parameters
if nargout > 0
    varargout = {h};
end
