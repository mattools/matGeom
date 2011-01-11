function varargout = drawMesh(vertices, faces, varargin)
%DRAWMESH Draw a 3D mesh defined by vertices and faces
%
%   drawMesh(VERTICES, FACES)
%   Draws the 3D mesh defined by vertices VERTICES and the faces FACES. 
%   vertices is a [NVx3] array containing coordinates of vertices, and FACES
%   is either a [NFx3] or [NFx4] array containing indices of vertices of
%   the triangular or rectangular faces.
%   FACES can also be a cell array, in the content of each cell is an array
%   of indices to the vertices of the current face. Faces can have different
%   number of vertices.
%   
%   drawMesh(MESH)
%   Where mesh is a structure with fields 'vertices' and 'faces', draws the
%   given mesh.
%
%   drawMesh(..., COLOR)
%   Use the specified color to render the mesh faces.
%
%   drawMesh(..., NAME, VALUE)
%   Use one or several pairs of parameter name/value to specify drawing
%   options. Options are the same as the 'patch' function.
%
%
%   H = drawMesh(...);
%   Also returns a handle to the created patch.
%
%   Example:
%     [v f] = createSoccerBall;
%     drawMesh(v, f);
%
%   See also:
%   polyhedra, meshes3d, patch
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


%% Initialisations

% Check if the input is a mesh structure
if isstruct(vertices)
    % refresh options
    if nargin > 1
        varargin = [{faces} varargin];
    end
    
    % extract data to display
    faces = vertices.faces;
    vertices = vertices.vertices;
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
        % otherwise keep varargin unchanged
end

% overwrites on current figure
hold on;

% if vertices are 2D points, add a z=0 coordinate
if size(vertices, 2)==2
    vertices(1,3)=0;
end


%% Use different processing depending on the type of faces
if isnumeric(faces)
    % array FACES is a NC*NV indices array, with NV : number of vertices of
    % each face, and NC number of faces
    h = patch('vertices', vertices, 'faces', faces, varargin{:});

elseif iscell(faces)
    % array FACES is a cell array
    h = zeros(length(faces(:)), 1);

    for f=1:length(faces(:))
        % get vertices of the cell
        face = faces{f};

        % Special processing in case of multiple polygonal face:
        % each polygonal loop is separated by a NaN.
        if sum(isnan(face))~=0
            
            % find indices of loops breaks
            inds = find(isnan(face));
            
            % replace NaNs by index of first vertex of each polygon
            face(inds(2:end))   = face(inds(1:end-1)+1);
            face(inds(1))       = face(1);
            face(length(face)+1)= face(inds(end)+1);            
        end
        
        % draw current face
        cnodes  = vertices(face, :);
        h(f)    = patch(cnodes(:, 1), cnodes(:, 2), cnodes(:, 3), [1 0 0]);
    end
    
    % set up drawing options
    set(h, varargin{:});
else
    error('second argument must be a face array');
end


%% Process output arguments

% format output parameters
if nargout>0
    varargout{1}=h;
end
