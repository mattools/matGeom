function mesh = readMesh_obj(fileName)
% Read mesh data stored in OBJ format.
%
%   MESH = readMesh_obj(FILENAME)
%   Read the data stored in file FILENAME and return the mesh into a struct
%   with fields 'vertices' and 'faces'.
%
%   Example
%     mesh = readMesh_obj('teapot.obj');
%     figure; drawMesh(mesh, 'facecolor', [.5 .5 .5]);
%     axis equal; light;
%
%   References
%   Adapted from Bernard Abayowa (2022). readObj
%   (https://www.mathworks.com/matlabcentral/fileexchange/18957-readobj),
%   MATLAB Central File Exchange. Retrieved September 8, 2022.  
%
%   See also
%     meshes3d, readMesh, readMesh_off, drawMesh
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2022-09-08,    using Matlab 9.9.0.1570001 (R2020b) Update 4
% Copyright 2022 INRAE.


%% initialisations

% open file
fid = fopen(fileName);
if fid == -1 
    error('matGeom:readMesh_obj:FileNotFound', ...
        ['Could not open input file: ' fileName]);
end

% prepare data accumulators
v = []; vt = []; vn = []; 
fv = []; fvt = []; fvn = [];


%% File parsing

% parse lines of OBJ file within infinite loop
lineIndex = 0;
while true
    % read current line
    line = fgetl(fid);
    lineIndex = lineIndex + 1;
    
    % check end of file to break the loop
    if ~ischar(line)
        break;
    end  
    
    % parse element type
    type = sscanf(line, '%s', 1);
    
    switch type
        case 'v'
            % parse vertex
            v = [v; sscanf(line(2:end), '%f')']; %#ok<AGROW>
            
        case 'vt'
            % parse texture coordinate
            vt = [vt; sscanf(line(3:end), '%f')']; %#ok<AGROW>
            
        case 'vn'
            % parse normal coordinates
            vn = [vn; sscanf(line(3:end), '%f')']; %#ok<AGROW>
            
        case 'f'
            % parse face data
            
            % transform current line into a 3-by-nt matrix of tokens
            str = textscan(line(2:end), '%s');
            tokenMatrix = split(str{1}, '/');
            
            % parse vertex indices (first column of matrix)
            fv = [fv ; str2double(tokenMatrix(:,1)')]; %#ok<AGROW>
            
            % parse texture coordinates (second column of matrix)
            if size(tokenMatrix, 2) > 1 && ~isempty(tokenMatrix{1,2})
                fvt = [fvt ; str2double(tokenMatrix(:,2)')]; %#ok<AGROW>
            end
            
            % parse normal coordinates (third column of matrix)
            if size(tokenMatrix, 2) > 2 && ~isempty(tokenMatrix{1,3})
                fvn = [fvn ; str2double(tokenMatrix(:,3)')]; %#ok<AGROW>
            end

            % The following code is slightly faster, but does not manage
            % all possible cases (in particular when face texture is empty)
            % and is more complicated to maintain.
%             str = textscan(line(2:end), '%s'); 
%             str = str{1};
%             fvi = []; fvti = []; fvni = [];
%             
%             % number of fields with this face vertices
%             nf = length(strfind(str{1}, '/')); 
%             
%             % vertex indices
%             [tok, str] = strtok(str, '//'); %#ok<STTOK>
%             for k = 1:length(tok)
%                 fvi = [fvi str2double(tok{k})]; %#ok<AGROW>
%             end
%             fv = [fv; fvi];    %#ok<AGROW>
%             
%             % vertex texture coordinates
%             if nf > 0
%                 [tok, str] = strtok(str, '//'); %#ok<STTOK>
%                 for k = 1:length(tok)
%                     fvti = [fvti str2double(tok{k})]; %#ok<AGROW>
%                 end
%                 fvt = [fvt; fvti]; %#ok<AGROW>
%             end
%             
%             % vertex normal coordinates
%             if nf > 1
%                 tok = strtok(str, '//');
%                 for k = 1:length(tok)
%                     fvni = [fvni str2double(tok{k})]; %#ok<AGROW>
%                 end
%                 fvn = [fvn; fvni]; %#ok<AGROW>
%             end
            
        case {'g', 'o', 's', 'usemtl'}
            warning('matGeom:readMesh_obj:UnsupportedElement', ......
                'Element %s at line %d is not (yet) managed', type, lineIndex);
            
        case {'#', '', ' '}
            % do nothing
            
        otherwise
            warning('matGeom:readMesh_obj:UnknownElement', ......
                'Unknown element type at line %d: %s', lineIndex, type);
    end
end

% close file
fclose(fid);


%% Format output

% create mesh structure
mesh = struct('vertices', v);

% add optional vertex data
if ~isempty(vn)
    mesh.vertexNormals = vn;
end
if ~isempty(vt)
    mesh.vertexTexture = vt;
end

% face vertex indices
mesh.faces = fv;

% add optional face data
if ~isempty(fvn)
    mesh.faceVertexNormals = fvn;
end
if ~isempty(fvt)
    mesh.faceVertexTexture = fvt;
end
