function polyShape = polygonToPolyshape(poly, varargin)
%POLYGONTOPOLYSHAPE Convert a matGeom polygon to a MATLAB polyshape object.
%
%   POLYSHAPE = polygonToPolyshape(POLY)
%
%   Example
%     poly = [0 0; 1 0; 1 1; 0 1];
%     polyShape = polygonToPolyshape(poly);
%     figure('color','w')
%     axis equal tight; hold on; xlabel('x'); ylabel('y')
%     plot(polyShape)
%
%   See also 
%   rowToPolygon

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2022-12-31, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2022-2023

parser = inputParser;
logParValidFunc = @(x) (islogical(x) || isequal(x,1) || isequal(x,0));
addParameter(parser,'debugVisualization', false, logParValidFunc);
parse(parser, varargin{:});
debugVisu = parser.Results.debugVisualization;

polyShape = parsePolygon(poly, 'polyshape');

if debugVisu
    figure('color','w','numbertitle','off', ...
        'name', ['Debug Figure: ' mfilename ...
        '.m: MATLAB polyshape object']);
    axis equal tight; hold on; xlabel('x'); ylabel('y')
    plot(polyShape)
end

end
