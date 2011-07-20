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

directories = {...
    'geom2d', ...
    'polygons2d', ...
    'graphs', ...
    'geom3d', ...
    'meshes3d', ...
    };

for i = 1:length(directories)
    name = directories{i};
    disp(['Running tests for directory: ' name]);
    
    cd(name);
    runtests;
    cd('..');
end

    