function varargout = drawPolyhedra(varargin)
%DRAWPOLYHEDRA draw polyhedra defined by vertices and faces
%
%   DEPRECATED: use drawPolyhedron instead.
%
%   drawPolyhedra(NODES, FACES)
%   Draw the polyhedra defined by vertices NODES and the faces FACES. 
%   NODES is a [NNx3] array containing coordinates of vertices, and FACES
%   is either a [NFx3] or [NFx4] array containing indices of vertices of
%   the tria,gular or rectangular faces.
%   FACES can also be a cell array, in the content of each cell is an array
%   of indices to the nodes of the current face. Faces can have different
%   number of vertices.
%   
%   H = drawPolyhedra(...) also return handles to the created patches.
%
%   Example:
%   [n f] = createSoccerBall;
%   drawPolyhedra(n, f);
%
%   See also : drawPolygon, drawPolyhedron
%
%   ---------
%
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 10/02/2005.
%

%   HISTORY
%   07/11/2005 update doc.
%   04/01/2007 typo
%   18/01/2007 add support for 2D polyhedra ("nodes" is N-by-2 array), and
%       make 'cnodes' a list of points instead of a list of indices
%   14/08/2007 add comment, add support for NaN in faces (complex polygons)
%   17/10/2008 deprecate and add warning


warning('IMAEL:deprecatedFunction', ...
    'This function is deprecated, use ''drawPolyhedron'' instead');


%% Initialisations

% process input parameters
if length(varargin)<=2
    nodes = varargin{1};
    faces = varargin{2};
else
    error ('wrong number of arguments in "drawPolyhedra"');
end

% default color is red
color = [1 0 0];

% overwrites on current figure
hold on;

% if nodes are 2D points, add a z=0 coordinate
if size(nodes, 2)==2
    nodes(1,3)=0;
end


%% main loop : for each face

if iscell(faces)
    % array FACES is a cell array
    h = zeros(length(faces(:)), 1);

    for f=1:length(faces(:))
        % get nodes of the cell
        face = faces{f};

        if sum(isnan(face))~=0
            % Special processing in case of multiple polygonal face.
            % each polygonal loop is separated by a NaN.
            
            % find indices of loops breaks
            inds = find(isnan(face));
            
            % replace NaNs by index of first vertex of each polygon
            face(inds(2:end))   = face(inds(1:end-1)+1);
            face(inds(1))       = face(1);
            face(length(face)+1)= face(inds(end)+1);
            
        end
        
        % draw current face
        cnodes  = nodes(face, :);
        h(f)    = patch(cnodes(:, 1), cnodes(:, 2), cnodes(:, 3), color);
    end

else
    % array FACES is a NC*NV indices array, with NV : number of vertices of
    % each face, and NC number of faces
    h = zeros(size(faces, 1), 1);
    for f=1:size(faces, 1)
        % get nodes of the cell
        cnodes = nodes(faces(f,:)', :);
        h(f) = patch(cnodes(:, 1), cnodes(:, 2), cnodes(:, 3), color);
    end
end


% format output parameters
if nargout>0
    varargout{1}=h;
end