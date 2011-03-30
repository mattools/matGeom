function poly = rowToPolygon(row, varargin)
%ROWTOPOLYGON  Create a polygon from a row vector
%
%   output = rowToPolygon(input)
%
%   Example
%   rowToPolygon
%
%   See also
%
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
