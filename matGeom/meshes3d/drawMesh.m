function varargout = drawMesh(varargin)
%DRAWMESH Draw a 3D mesh defined by vertex and face arrays.
%
%   drawMesh(VERTICES, FACES)
%   Draws the 3D mesh defined by vertices VERTICES and the faces FACES. 
%   vertices is a NV-by-3 array containing coordinates of vertices, and
%   FACES is either a NF-by-3 or NF-by-4 array containing face vertex
%   indices of the triangular or rectangular faces.
%   FACES can also be a cell array, in the content of each cell is an array
%   of indices to the vertices of the current face. Faces can have
%   different number of vertices.
%   
%   drawMesh(MESH)
%   Specifies the mesh as a structure with at least the fields 'vertices'
%   and 'faces'. 
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
%     [v, f] = createSoccerBall;
%     drawMesh(v, f);
%
%   See also:
%     meshes3d, polyhedra, patch
%

%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2005.
%

%   HISTORY
%   07/11/2005 update doc.
%   04/01/2007 typo
%   18/01/2007 add support for 2D polyhedra ("vertices" is N-by-2 array), and
%       make 'cnodes' a list of points instead of a list of indices
%   14/08/2007 add comment, add support for NaN in faces (complex polygons)
%   14/09/2007 rename as drawPolyhedron
%   16/10/2008 better support for colors
%   27/07/2010 renamed as drawMesh
%   09/11/2010 update doc
%   07/12/2010 update management of mesh structures


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

% process input arguments
switch length(varargin)
    case 0 
        % default color is red
        varargin = {'facecolor', [1 0 0]};
    case 1
        % use argument as color for faces
        varargin = {'facecolor', varargin{1}};
    otherwise
        % otherwise add default settings before new options
        varargin = [{'facecolor', [1 0 0 ]} varargin];

end

% overwrites on current figure
hold(ax, 'on');

% if vertices are 2D points, add a z=0 coordinate
if size(vertices, 2) == 2
    vertices(1, 3) = 0;
end


%% Use different processing depending on the type of faces
if isnumeric(faces)
    % array FACES is a NC*NV indices array, with NV : number of vertices of
    % each face, and NC number of faces
    h = patch('vertices', vertices, 'faces', faces, varargin{:}, ...
        'Parent', ax);

elseif iscell(faces)
    % array FACES is a cell array
    h = zeros(length(faces(:)), 1);

    for f = 1:length(faces(:))
        % get vertices of the cell
        face = faces{f};

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
        cnodes  = vertices(face, :);
        h(f)    = patch(ax, cnodes(:, 1), cnodes(:, 2), cnodes(:, 3), [1 0 0]);
    end
    
    % set up drawing options
    set(h, varargin{:});
else
    error('second argument must be a face array');
end


%% Process output arguments

% format output parameters
if nargout > 0
    varargout = {h};
end
