function runAllTests(varargin)
%RUNALLTESTS  Explore all subdirectories, and run 'runtests' function
%
%   output = runAllTests(input)
%
%   Example
%   runAllTests
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-07-20,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% Change the directory 
cd(fileparts(mfilename('fullpath')))

% Add matGeom to path
addpath(genpath(strrep(mfilename('fullpath'),['tests' filesep mfilename],'matGeom')))

directories = {...
    'geom2d', ...
    'geom3d', ...
    'graphs', ...
    'meshes3d', ...
    'polygons2d', ...
    };

for i = 1:length(directories)
    name = directories{i};
    disp(['Running tests for directory: ' name]);
    
    cd(name);
    runtests;
    cd('..');
end