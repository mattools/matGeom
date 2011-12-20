function [vertices faces] = readMesh_off(fileName)
%READMESH_OFF Read mesh data stord in OFF format
%
%   [VERTICES FACES] = readMesh_off(FILNAME)
%
%   Example
%   readMesh_off
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-12-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% open file
f = fopen(fileName, 'r');
if f == -1 
    error('matGeom:readMesh_off:FileNotFound', ...
        ['Could not find file: ' fileName]);
end

% check format
line = fgets(f);   % -1 if eof
if ~strcmp(line(1:3), 'OFF')
    error('matGeom:readMesh_off:FileFormatError', ...
        'Not a valid OFF file');    
end

% number of faces and vertices
line = fgets(f);
vals = sscanf(line, '%d %d');
nv = vals(1);
nf = vals(2);


% read vertex data
[vertices count] = fscanf(f, '%f ', [3 nv]);
if count ~= nv*3
    error('matGeom:readMesh_off:FileFormatError', ...
        ['Could not read all the ' num2str(nv) ' vertices']);
end
vertices = vertices';

% read face data (face start by index)
[faces count] = fscanf(f, '%d %d %d %d\n', [4 nf]);
if count ~= nf * 4
    error('matGeom:readMesh_off:FileFormatError', ...
        ['Could not read all the ' num2str(nf) ' faces']);
end

% clean up: remove index, and use 1-indexing
faces = faces(2:4, :)' + 1;

% close the file
fclose(f);

