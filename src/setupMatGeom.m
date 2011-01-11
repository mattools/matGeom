function setupMatGeom(varargin)
%SETUPMATGEOM Add the different directories of MatGeom to the path
%
%   Usage:
%   setupMatGeom;
%
%   Example
%   setupMatGeom;
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-01-11,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.

% extract library path
fileName = mfilename('fullpath');
libDir = fileparts(fileName);

% add all library modules
addpath(fullfile(libDir, 'geom2d'));
addpath(fullfile(libDir, 'polygons2d'));
addpath(fullfile(libDir, 'polynomialCurves2d'));
addpath(fullfile(libDir, 'geom3d'));
addpath(fullfile(libDir, 'meshes3d'));
