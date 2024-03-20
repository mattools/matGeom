function setupMatGeom(varargin)
%SETUPMATGEOM Add the different directories of MatGeom to the path.
%
%   Usage:
%   setupMatGeom;
%
%   Example
%   setupMatGeom;
%
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-01-11, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2023 INRA - Cepia Software Platform

% extract library path
fileName = mfilename('fullpath');
libDir = fileparts(fileName);

moduleNames = {...
    'geom2d', ...
    'polygons2d', ...
    'graphs', ...
    'geom3d', ...
    'meshes3d', ...
    'utils'};

disp('Installing MatGeom Library');
addpath(libDir);

% add all library modules
for i = 1:length(moduleNames)
    name = moduleNames{i};
    fprintf('Adding module: %-20s', name);
    addpath(fullfile(libDir, name));
    disp(' (ok)');
end

