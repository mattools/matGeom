function boxes3d(varargin)
%BOXES3D Description of functions operating on 3D boxes.
%
%   A box defined by its coordinate extents: 
%   BOX = [XMIN XMAX YMIN YMAX ZMIN ZMAX].
%
%   Example
%   % Draw a polyhedron together with its bounding box   
%   [n e f]= createIcosahedron;
%   drawPolyhedron(n, f);
%   hold on;
%   drawBox3d(point3dBounds(n))
%
%
%   See also 
%   boundingBox3d, box3dVolume, drawBox3d
%   intersectBoxes3d, mergeBoxes3d, randomPointInBox3d
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2010-07-26, using Matlab 7.9.0.529 (R2009b)
% Copyright 2010-2023 INRA - Cepia Software Platform
