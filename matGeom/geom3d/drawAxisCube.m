function p = drawAxisCube(varargin)
%DRAWAXISCUBE Draw a colored cube representing axis orientation.
%
%   output = drawAxisCube(input)
%
%   Example
%   drawAxisCube
%
%   See also 
%     drawAxis3d, createCube, patch

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2010-07-22, using Matlab 7.9.0.529 (R2009b)
% Copyright 2010-2023 INRA - Cepia Software Platform

if nargin > 0 && isAxisHandle(varargin{1})
    hAx = varargin{1};
%     varargin(1) = [];
else
    hAx = gca;
end

[n, e, f] = createCube; %#ok<ASGLU>

faceColors = [ ...
    1 1 0; ...
    0 0 1; ...
    1 0 0; ...
    0 1 1; ...
    1 0 1; ...
    0 1 0; ...
    ];

p = patch(hAx, 'vertices', n, 'faces', f, ...
    'facecolor', 'flat', 'FaceVertexCData', faceColors);
    
