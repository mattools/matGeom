function poly = rowToPolygon(row, varargin)
%ROWTOPOLYGON  Create a polygon from a row vector
%
%   POLY = rowToPolygon(ROW)
%   Convert a 1-by-2*N row vector that concatenates all polygon vertex
%   coordinates into a N-by-2 array of coordinates.
%   Default ordering of coordinates in ROW is:
%   [X1 Y1 X2 Y2 X3 Y3 .... XN YN].
%
%   POLY = rowToPolygon(ROW, METHOD)
%   Specifies the method for concatenating coordinates. METHOS is one of:
%   'interlaced': default method, described above.
%   'packed': the vector ROW has format:
%   [X1 X2 X3 ... XN Y1 Y2 Y3 ... YN].
%
%   Example
%   % Concatenate coordinates of a circle and draw it as a polygon
%     t = linspace (0, 2*pi, 200);
%     row = [cos(t) sin(t)];
%     poly = rowToPolygon(row, 'packed');
%     figure;drawPolygon(poly)
%
%   See also
%   polygons2d, polygonToRow
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

type = 'interlaced';
if ~isempty(varargin)
    type = varargin{1};
end

% polygon vertex number
Np = length(row)/2;
    
if strcmp(type, 'interlaced')
    % ordering is [X1 Y1 X2 X2... XN YN]
    poly = reshape(row, [2 Np])';
    
elseif strcmp(type, 'packed')
    % ordering is [X1 X2 X3... XN Y1 Y2 Y3... YN]
    poly = [row(1:Np)' row(Np+1:end)'];
end
