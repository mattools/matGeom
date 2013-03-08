function polys = readPolygonSet(filename)
%READPOLYGONSET Read a set of simple polygons stored in a file
%   
%   POLY = readPolygonSet(FILENAME);
%   Returns the polygon stored in the file FILENAME.
%   Polygons are assumed to be stored in text files, without headers, with
%   x and y coordinates packed in two separate lines:
%     X11 X12 X13 ... X1N
%     Y11 Y12 Y13 ... Y1N
%     X21 X22 X23 ... X2N
%     Y21 Y22 Y23 ... Y2N
%
%   Each polygon may have a different number of vertices. The result is a
%   cell array of polygon, each cell containing a N-by-2 array representing
%   the vertex coordinates.
%
%   See also:
%   polygons2d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/04/2004.
%

% the set of polygons (no pre-allocation, as we do not know how many
% polygons are stored)
polys = {};

% index of polygon
p = 0;

% open file for reading
fid = fopen(filename, 'rt');

% use an infinite loop, terminated in case of EOF
while true
    % set of X, and Y coordinates 
    line1 = fgetl(fid);
    line2 = fgetl(fid);
    
    % break loop if end of file is reached
    if line1 == -1
        break;
    end
   
    % create a new polygon by concatenating vertex coordinates
    p = p + 1;
    polys{p} = [str2num(line1)' str2num(line2)']; %#ok<AGROW,ST2NM>
end    

% close file
fclose(fid);
