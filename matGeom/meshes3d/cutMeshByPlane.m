function varargout = cutMeshByPlane(v, f, plane, varargin)
%CUTMESHBYPLANE Cut a mesh by a plane
%   [ABOVE, IN, BELOW] = cutMeshByPlane(MESH, PLANE)
%   where MESH, ABOVE, IN, BELOW are structs with the fields vertices and
%   faces, and PLANE is given as a row containing initial point and 2
%   direction vectors. ABOVE, IN, BELOW contain the corresponding parts of
%   the input mesh.
%
%   [ABOVE_V, ABOVE_F, IN_V, IN_F, BELOW_V,BELOW_F] = ...
%       cutMeshByPlane(V, F, PLANE) where V is a [NVx3] array containing
%   coordinates and F is a [NFx3] array containing indices of vertices of
%   the triangular faces.
%
%   BELOW = cutMeshByPlane(V, F, PLANE, 'part', 'below') BELOW is a struct
%   with the fields vertices and faces. Other options are:
%       'part'  -   'above': Faces above the plane
%               -   'in'   : Faces in the plane
%               -   'below': Faces below the plane
%
%   [BELOW_V, BELOW_F] = cutMeshByPlane(MESH, PLANE, 'part', 'below') is
%   possible, too.
%
% ---------
% Authors: oqilipo, David Legland
% Created: 2017-07-09
% Copyright 2017

narginchk(2,5)
nargoutchk(1,6)


%% Parse inputs
% If first argument is a struct
if nargin == 2 || nargin == 4
    if ~isempty(varargin)
        varargin={plane, varargin{:}};
    end
    plane = f;
    [v, f] = parseMeshData(v);
end

p = inputParser;
addRequired(p,'plane',@isPlane)
validStrings = {'above','in','below'};
addParameter(p,'part','above',@(x) any(validatestring(x, validStrings)))
parse(p, plane, varargin{:});
part=p.Results.part;


%% Algorithm
% Logical index to the vertices below the plane
VBPl_LI = isBelowPlane(v, plane);

% Logical index to three vertices of each face
FBP_LI = VBPl_LI(f);
switch nargout
    case {1, 2}
        switch part
            case 'above'
                % Faces above the plane, all three vertices == 0 -> sum has to be 0
                above = removeMeshFaces(v, f, ~(sum(FBP_LI, 2) == 0) );
            case 'in'
                % Faces in the plane, 1 or 2 vertices == 0 -> sum can be 1 or 2
                inside = removeMeshFaces(v, f, ~((sum(FBP_LI, 2) > 0 & sum(FBP_LI, 2) < 3)));
            case 'below'
                % Faces below the plane, all three vertices == 1 -> sum has to be 3
                below = removeMeshFaces(v, f, ~(sum(FBP_LI, 2) == 3) );
        end
    case {3, 6}
        % Faces above the plane, all three vertices == 0 -> sum has to be 0
        above = removeMeshFaces(v, f, ~(sum(FBP_LI, 2) == 0) );
        % Faces in the plane, 1 or 2 vertices == 0 -> sum can be 1 or 2
        inside = removeMeshFaces(v, f, ~((sum(FBP_LI, 2) > 0 & sum(FBP_LI, 2) < 3)));
        % Faces below the plane, all three vertices == 1 -> sum has to be 3
        below = removeMeshFaces(v, f, ~(sum(FBP_LI, 2) == 3) );
    otherwise
        error('Invalid number of output arguments')
end


%% Parse outputs
switch nargout
    case 1
        switch part
            case 'above'
                varargout{1}=above;
            case 'in'
                varargout{1}=inside;
            case 'below'
                varargout{1}=below;
        end
    case 2
        switch part
            case 'above'
                varargout{1}=above.vertices;
                varargout{2}=above.faces;
            case 'in'
                varargout{1}=inside.vertices;
                varargout{2}=inside.faces;
            case 'below'
                varargout{1}=below.vertices;
                varargout{2}=below.faces;
        end
    case 3
        varargout{1}=above;
        varargout{2}=inside;
        varargout{3}=below;
    case 6
        varargout{1}=above.vertices;
        varargout{2}=above.faces;
        varargout{3}=inside.vertices;
        varargout{4}=inside.faces;
        varargout{5}=below.vertices;
        varargout{6}=below.faces;
    otherwise
        error('Invalid number of output arguments')
end

end