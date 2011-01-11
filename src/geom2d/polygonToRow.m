function row = polygonToRow(polygon, varargin)
%POLYGONTOROW Convert polygon coordinates to a row vector
%
%   ROW = polygonToRow(POLY);
%   where POLY is a N-by-2 array of points representing vertices of the
%   polygon, converts the vertex coordinates into a linear array:
%   ROW = [X1 Y1 X2 Y2 .... XN YN]
%
%   ROW = polygonToRow(POLY, TYPE);
%   Can coose another format for converting polygon. Possibilities are:
%   'interlaced' (default}, as described above
%   'packed': ROW has format [X1 X2 ... XN Y1 Y2 ... YN].
%
%   Example
%   square = [10 10 ; 20 10 ; 20 20 ; 10 20];
%   row = polygonToRow(square)
%   row = 
%       10   10   20   10   20   20   10   20 
%
%   % the same with different ordering
%   row = polygonToRow(square, 'packed')
%   row = 
%       10   20   20   10   10   10   20   20 
%
%
%   See also
%   polygons2d, rowToPolygon
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-07-23,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% determines ordering type
type = 'interlaced';
if ~isempty(varargin)
    type = varargin{1};
end


if strcmp(type, 'interlaced')
    % ordering is [X1 Y1 X2 X2... XN YN]
    Np = size(polygon, 1);
    row = reshape(polygon', [1 2*Np]);
    
elseif strcmp(type, 'packed')
    % ordering is [X1 X2 X3... XN Y1 Y2 Y3... YN]
    row = polygon(:)';
end
