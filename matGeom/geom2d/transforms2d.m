function transforms2d(varargin)
%TRANSFORMS2D Description of functions operating on transforms
%
%   By 'transform' we mean an affine transform. A planar affine transform
%   can be represented by a 3x3 matrix.
%
%   Example
%   % create a translation by the vector [10 20]:
%   T = createTranslation([10 20])
%   T =
%        1     0    10
%        0     1    20
%        0     0     1
%
%
%   See also:
%   createTranslation, createRotation, createScaling, createBasisTransform
%   createHomothecy, createLineReflection, fitAffineTransform2d
%   transformPoint, transformVector, transformLine, transformEdge
%   rotateVector
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

help('transforms2d');