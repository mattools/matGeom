function polys = readPolygon(filename)
%READPOLYGON read a polygon stored in a file
%   
%   POLY = readPolygon(FILENAME);
%   Returns the polygon stored in the file FILENAME.
%
%   See also:
%   polygons2d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 11/04/2004.
%


polys = {};
p=0;

fid = fopen(filename, 'rt');

while true    
    line1 = fgetl(fid);
    line2 = fgetl(fid);
    
    % break loop if reah end of file
    if line1 == -1
        break;
    end
   
    p = p+1;
    polys{p} = [str2num(line1)' str2num(line2)'];
end    
