function varargout = concatenateMeshes(varargin)
%CONCATENATEMESHES Concatenate multiple meshes.
%
%   [V, F] = concatenateMeshes(V1, F1, V2, F2, ...)
%   Returns one mesh represented by vertices V and faces F by concatenating
%   the meshes defined by V1, V2, ... and F1, F2, ...
%
%   [V, F] = concatenateMeshes(MESH1, MESH2, ...)
%   where MESH1, MESH2, ... are structs or struct arrays with the fields  
%   vertices and faces
%
%   Example
%     apple = readMesh('apple.ply');
%     apple.vertices = apple.vertices*50;
%     apple = transformMesh(apple, ...
%         createTranslation3d([-7 -6 0])*createRotationOx(pi/2));
%     bunny = readMesh('bunny_F1k.ply');
%     bunnyEatsApple = concatenateMeshes(bunny, apple);
%     drawMesh(bunnyEatsApple)
%     view(3)
%
%   See also 
%     splitMesh

% ------
% Authors: oqilipo (parsing), Alec Jacobson (loop)
% E-mail: N/A
% Created: 2017-09-12
% Copyright 2017-2024

%% parsing inputs
assert(~isempty(varargin))

if isstruct(varargin{1})
    VF_fields = {'vertices','faces'};
    
    errorStructFields=['If the first input argument is a struct '...
        'with the fields vertices and faces the additonal ' ...
        'arguments must have the same format'];
    % Check, if all input arguments are structs
    assert(all(cellfun(@isstruct, varargin)), errorStructFields)
    % Check, if all structs contain the two fields vertices and faces
    assert(all(cellfun(@(x) all(ismember(VF_fields, ...
        fieldnames(x))), varargin)), errorStructFields)

    % Delete all fields except vertices and faces
    for s = 1:length(varargin)
        delFields = fieldnames(varargin{s});
        delFields(ismember(fieldnames(varargin{s}), VF_fields))=[];
        varargin{s} = rmfield(varargin{s}, delFields);
    end
    
    
    if isscalar(varargin)
        errorArgAndStructLength = ['If the input is only one struct ' ...
            'it has to contain more than one mesh.'];
        assert(length(varargin{1})>1, ...
            errorArgAndStructLength)
    end
    
    % Order of the fields: vertices, faces
    varargin = cellfun(@(x) orderfields(x, VF_fields),varargin, 'UniformOutput',0);
    
    % Convert the structs into one cell array
    varargin = cellfun(@struct2cell, varargin, 'UniformOutput', false);
    varargin = cellfun(@squeeze, varargin, 'UniformOutput',0);
    varargin = reshape([varargin{:}],[],1)';
end

NoA = length(varargin);
assert(mod(NoA,2)==0);

cellfun(@(x) validateattributes(x, {'numeric'},...
    {'size',[NaN,3],'finite'}), varargin(1:2:end))
cellfun(@(x) validateattributes(x, {'numeric'},...
    {'integer'}), varargin(2:2:end))
% Check if all faces have the same number of columns
errorFacesRows='The faces of all meshes must have the same number of columns';
assert(isscalar(unique(cellfun(@(x) size(x,2), varargin(2:2:end)))), errorFacesRows)


%% loop
v = [];
f = [];
for m = 1:NoA/2
    vm = varargin{2*m-1};
    fm = varargin{2*m};
    f = [f; fm+size(v,1)]; %#ok<AGROW>
    v = [v; vm]; %#ok<AGROW>
end


%% parsing outputs
[v, f] = trimMesh(v, f);

switch nargout
    case 1
        mesh.vertices = v;
        mesh.faces = f;
        varargout{1} = mesh;
    case 2
        varargout{1} = v;
        varargout{2} = f;
end