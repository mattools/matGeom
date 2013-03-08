function writePolygonSet(polys, filename)
%WRITEPOLYGONSET Write a set of simple polygons into a file
%   
%   writePolygonSet(POLYS, FILENAME);
%   Writes the set of polygons in the file FILENAME.
%   Following format is used:
%     X11 X12 X13 ... X1N
%     Y11 Y12 Y13 ... Y1N
%     X21 X22 X23 ... X2N
%     Y21 Y22 Y23 ... Y2N
%   Each polygon may have a different number of vertices. 
%
%   See also:
%   polygons2d, readPolygonSet
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 14/01/2013.
%


% open file for reading
fid = fopen(filename, 'wt');

for i = 1:length(polys)
    poly = polys{i};
    n = size(poly, 1);
    
    % precompute format
    format = [repmat('%g ', 1, n) '\n'];
    
    % write one line for x, then one line for y
    fprintf(fid, format, poly(:,1)');
    fprintf(fid, format, poly(:,2)');    
end

% close file
fclose(fid);