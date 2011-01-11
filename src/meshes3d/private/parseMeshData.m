function varargout = parseMeshData(varargin)
%PARSEMESHDATA Conversion of data representation for meshes
%
%   MESH = parseMeshData(VERTICES, EDGES, FACES)
%   MESH = parseMeshData(VERTICES, FACES)
%   [VERTICES EDGES FACES] = parseMeshData(MESH)
%   [VERTICES FACES] = parseMeshData(MESH)
%
%
%   See also
%   meshes3d, formatMeshOutput
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-06,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% initialize edges
edges = [];

% Process input arguments
if nargin == 1
    % input is a data structure
    mesh = varargin{1};
    vertices = mesh.vertices;
    faces = mesh.faces;
    if isfield(mesh, 'edges')
        edges = mesh.edges;
    end
    
elseif nargin == 2
    % input are vertices and faces
    vertices = varargin{1};
    faces = varargin{2};
    
elseif nargin == 3
    % input are vertices, edges and faces
    vertices = varargin{1};
    edges = varargin{2};
    faces = varargin{3};
    
else
    error('Wrong number of arguments');
end

varargout = formatMeshOutput(nargout, vertices, edges, faces);
