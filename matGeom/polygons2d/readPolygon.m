function polys = readPolygon(filename)
%READPOLYGON Read a polygon stored in a file
%   
%   POLY = readPolygon(FILENAME);
%   Returns the polygon stored in the file FILENAME.
%   Polygons are assumed to be stored in text files, without headers, with
%   x and y coordinates packed in two separate lines:
%     X1 X2 X3...
%     Y1 Y2 Y3...
%
%   See also:
%   polygons2d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/04/2004.
%

% the set ogf polygons (no pre-allocation, as we do not know how many
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
    p = p+1;
    polys{p} = [str2num(line1)' str2num(line2)']; %#ok<AGROW,ST2NM>
end    
