function lines3d(varargin)
%LINES3D Description of functions operating on 3D lines.
%
%   A 3D Line is represented by a 1-by-6 row vector containing a 3D point
%   (its origin) and a 3D vector (its direction):
%   LINE = [X0 Y0 Z0 DX DY DZ];
%
%   See also:
%   createLine3d, distancePointLine3d, isPointOnLine3d, linePosition3d 
%   intersectLinePlane, distanceLines3d, parallelLine3d, projPointOnLine3d
%   clipLine3d, fitLine3d, drawLine3d, transformLine3d
%   edgeToLine3d, lineToEdge3d
%   

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

help('lines3d');
