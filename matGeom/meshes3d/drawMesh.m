function varargout = drawMesh(varargin)
% Draw a 3D mesh defined by vertex and face arrays.
%
%   drawMesh(VERTICES, FACES)
%   Draws the 3D mesh defined by vertices VERTICES and the faces FACES. 
%   vertices is a NV-by-3 array containing coordinates of vertices, and
%   FACES is either a NF-by-3 or NF-by-4 array containing face vertex
%   indices of the triangular or rectangular faces.
%   FACES can also be a cell array, each cell containing an array of vertex
%   indices for the corresponding face. In this case the faces may have
%   variable number of vertices. 
%   
%   drawMesh(MESH)
%   Specifies the mesh as a structure containing at least the fields
%   'vertices' and 'faces', using the same conventions as above.
%
%   drawMesh(..., COLOR)
%   Use the specified color to render the mesh faces.
%
%   drawMesh(..., NAME, VALUE)
%   Use one or several pairs of parameter name/value to specify drawing
%   options. Options are the same as the 'patch' function.
%
%   drawMesh(AX,...) 
%   Draw into the axis specified by AX instead of the current axis.
%
%
%   H = drawMesh(...);
%   Also returns a handle to the created patch.
%
%   Example:
%     % display a polyhedra with polygonal faces
%     [v, f] = createSoccerBall;
%     drawMesh(v, f);
%
%     % Display a mesh representing a  torus, using uniform face color
%     [v, f] = torusMesh;
%     figure; hold on; axis equal; view(3);
%     drawMesh(v, f, 'FaceColor', 'g')
%     % paint the mesh according to vertex x-coordinate
%     figure; hold on; axis equal; view(3);
%     drawMesh(v, f, 'VertexColor', v(:,1), 'LineStyle', 'none');
%
%   See also:
%     meshes3d, polyhedra, patch
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2005.
%


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

% if vertices are 2D points, add a z=0 coordinate
if size(vertices, 2) == 2
    vertices(1, 3) = 0;
end


%% Pre-processing for formatting display options

% default color for drawing mesh
faceColor = [1 0 0];

% combine defualt face color with varargin
if isempty(varargin)
    varargin = [{'FaceColor'}, faceColor];
elseif length(varargin) == 1
    % if only one optional argument is provided, it is assumed to be color
    faceColor = varargin{1};
    varargin = [{'FaceColor'}, varargin];
elseif length(varargin) > 1
    % check if FaceColor option is specified, 
    % and if not use default face color
    indFC = strcmpi(varargin(1:2:end), 'FaceColor');
    if ~any(indFC)
        varargin = [{'FaceColor'}, {faceColor}, varargin];
    end
end

% check if simplified options are present
indVC = find(strcmpi(varargin(1:2:end), 'VertexColor'));
if ~isempty(indVC)
    vertexColor = varargin{indVC * 2};
    varargin([indVC*2-1 indVC*2]) = [];
    indFC = find(strcmpi(varargin(1:2:end), 'FaceColor'));
    if ~isempty(indFC)
        varargin([indFC*2-1 indFC*2]) = [];
    end
    varargin = [{'FaceVertexCData'}, {vertexColor}, {'FaceColor'}, {'interp'}, varargin];
end


%% Draw the mesh

% overwrite on current figure
hold(ax, 'on');

% Use different processing depending on the type of faces
if isnumeric(faces)
    % array FACES is a NF-by-NV indices array, with NF: number of faces,
    % and NV: number of vertices per face 
    h = patch('Parent', ax, ...
        'vertices', vertices, 'faces', faces, ...
        varargin{:});

elseif iscell(faces)
    % array FACES is a cell array. Need to draw each face as a single
    % patch.
    h = zeros(length(faces(:)), 1);

    for iFace = 1:length(faces(:))
        % get vertices of the cell
        face = faces{iFace};

        % Special processing in case of multiple polygonal face:
        % each polygonal loop is separated by a NaN.
        if sum(isnan(face)) ~= 0
            
            % find indices of loops breaks
            inds = find(isnan(face));
            
            % replace NaNs by index of first vertex of each polygon
            face(inds(2:end))   = face(inds(1:end-1)+1);
            face(inds(1))       = face(1);
            face(length(face)+1)= face(inds(end)+1);            
        end
        
        % draw current face
        cnodes = vertices(face, :);
        h(iFace) = patch(ax, cnodes(:, 1), cnodes(:, 2), cnodes(:, 3), faceColor);
    end
    
    % set up drawing options
    set(h, varargin{:});
else
    error('MatGeom:drawMesh', 'Second argument must be a face array');
end


%% Process output arguments

% format output parameters
if nargout > 0
    varargout = {h};
end
