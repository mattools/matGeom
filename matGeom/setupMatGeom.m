function setupMatGeom(varargin)
%SETUPMATGEOM Add the different directories of MatGeom to the path.
%
%   Usage:
%   setupMatGeom;
%   Run the setup script, adding the paths to the different modules of the
%   library.
%
%   setupMatGeom(PNAME, PVALUE);
%   Provides optional parameter name-value pairs. Possible parameter names
%   are:
%   'verbose'   (logical, default true) display information about the
%               installation process on the command line
%   'savePaths' (logical, default false) attempts to save the new 'path'
%               variable as default for future Matlab startup. This
%               operation may require administrator priviledge to update
%               the 'pathdef.m' file. 
%
%   Examples
%   setupMatGeom;
%   setupMatGeom('verbose', false);
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2011-01-11, using Matlab 7.9.0.529 (R2009b)
% Copyright 2011-2024 INRA - Cepia Software Platform

% default option values
verbose = true;
savePaths = false;

% parse input arguments 
parser = inputParser;
addParameter(parser, 'verbose', verbose, @islogical);
addParameter(parser, 'savePaths', savePaths, @islogical);
parser.parse(varargin{:});

% replace default values with options
verbose = parser.Results.verbose;
savePaths = parser.Results.savePaths;


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

if verbose
    disp('Installing MatGeom Library');
end
addpath(libDir);

% add all library modules
for i = 1:length(moduleNames)
    name = moduleNames{i};
    if verbose
        fprintf('Adding module: %-20s', name);
    end
    addpath(fullfile(libDir, name));
    if verbose
        disp(' (ok)');
    end
end

if savePaths
    savepath;
end