function varargout = readMesh_stl(fName)
%READMESH_STL Read mesh data stored in STL format.
%
%   [VERTICES, FACES] = readMesh_stl(FNAME)
%
%   MESH = readMesh_stl(FNAME)
%
%   See also
%     meshes3d, readMesh, readMesh_off, readMesh_ply, writeMesh_stl
%
%   Source
%     Functions of the stlTools toolbox by Pau Micó are used for STL files
%     in ASCII format:
%     https://mathworks.com/matlabcentral/fileexchange/51200-stltools
%     MATLAB's build-in stlread is used for STL files in binary format.

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2021-02-12, using Matlab 9.9.0.1538559 (R2020b)
% Copyright 2021-2023

format = stlGetFormat(fName);
if strcmp(format,'ascii')
    [vertices,faces] = stlReadAscii(fName);
elseif strcmp(format,'binary')
    TR = stlread(fName);
    vertices = TR.Points;
    faces = TR.ConnectivityList;
end

varargout = formatMeshOutput(nargout, vertices, faces);

end


function format = stlGetFormat(fileName)
%STLGETFORMAT identifies the format of the STL file and returns 'binary' or
%'ascii'

fid = fopen(fileName);
% Check the file size first, since binary files MUST have a size of 84+(50*n)
fseek(fid,0,1);         % Go to the end of the file
fidSIZE = ftell(fid);   % Check the size of the file
if rem(fidSIZE-84,50) > 0
    format = 'ascii';
else
    % Files with a size of 84+(50*n), might be either ascii or binary...
    % Read first 80 characters of the file.
    % For an ASCII file, the data should begin immediately (give or take a few
    % blank lines or spaces) and the first word must be 'solid'.
    % For a binary file, the first 80 characters contains the header.
    % It is bad practice to begin the header of a binary file with the word
    % 'solid', so it can be used to identify whether the file is ASCII or
    % binary.
    fseek(fid,0,-1); % go to the beginning of the file
    header = strtrim(char(fread(fid,80,'uchar')')); % trim leading and trailing spaces
    isSolid = strcmp(header(1:min(5,length(header))),'solid'); % take first 5 char
    fseek(fid,-80,1); % go to the end of the file minus 80 characters
    tail = char(fread(fid,80,'uchar')');
    isEndSolid = contains(tail,'endsolid');

    % Double check by reading the last 80 characters of the file.
    % For an ASCII file, the data should end (give or take a few
    % blank lines or spaces) with 'endsolid <object_name>'.
    % If the last 80 characters contains the word 'endsolid' then this
    % confirms that the file is indeed ASCII.
    if isSolid && isEndSolid
        format = 'ascii';
    else
        format = 'binary';
    end
end
fclose(fid);

end


function [v, f, n, name] = stlReadAscii(fileName)
%STLREADASCII reads a STL file written in ASCII format
%V are the vertices
%F are the faces
%N are the normals
%NAME is the name of the STL object (NOT the name of the STL file)

%======================
% STL ascii file format
%======================
% ASCII STL files have the following structure.  Technically each facet
% could be any 2D shape, but in practice only triangular facets tend to be
% used.  The present code ONLY works for meshes composed of triangular
% facets.
%
% solid object_name
% facet normal x y z
%   outer loop
%     vertex x y z
%     vertex x y z
%     vertex x y z
%   endloop
% endfacet
%
% <Repeat for all facets...>
%
% endsolid object_name

fid = fopen(fileName);
cellcontent = textscan(fid,'%s','delimiter','\n'); % read all the file and put content in cells
content = cellcontent{:}(logical(~strcmp(cellcontent{:},''))); % remove all blank lines
fclose(fid);

% read the STL name
line1 = char(content(1));
if (size(line1,2) >= 7)
    name = line1(7:end);
else
    name = 'Unnamed Object';
end

% read the vector normals
normals = char(content(logical(strncmp(content,'facet normal',12))));
n = str2num(normals(:,13:end));

% read the vertex coordinates (vertices)
vertices = char(content(logical(strncmp(content,'vertex',6))));
v = str2num(vertices(:,7:end));
nvert = length(vertices); % number of vertices
nfaces = sum(strcmp(content,'endfacet')); % number of faces
if (nvert == 3*nfaces)
    f = reshape(1:nvert,[3 nfaces])'; % create faces
end

% slim the file (delete duplicated vertices)
[v,f] = stlSlimVerts(v,f);

end


function [vnew, fnew]= stlSlimVerts(v, f)
% PATCHSLIM removes duplicate vertices in surface meshes.
% 
% This function finds and removes duplicate vertices.
%
% USAGE: [v, f]=patchslim(v, f)
%
% Where v is the vertex list and f is the face list specifying vertex
% connectivity.
%
% v contains the vertices for all triangles [3*n x 3].
% f contains the vertex lists defining each triangle face [n x 3].
%
% This will reduce the size of typical v matrix by about a factor of 6.
%
% For more information see:
%  http://www.esmonde-white.com/home/diversions/matlab-program-for-loading-stl-files
%
% Francis Esmonde-White, May 2010

if ~exist('v','var')
    error('The vertex list (v) must be specified.');
end
if ~exist('f','var')
    error('The vertex connectivity of the triangle faces (f) must be specified.');
end

[vnew, ~, indexn] =  unique(v, 'rows');
fnew = indexn(f);

end