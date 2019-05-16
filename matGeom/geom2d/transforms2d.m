function transforms2d(varargin)
%TRANSFORMS2D Description of functions operating on transforms.
%
%   By 'transform' we mean an affine transform. A planar affine transform
%   can be represented by a 3x3 matrix.
%
%   Example
%     % create a translation by the vector [10 20]:
%     T = createTranslation([10 20])
%     T =
%          1     0    10
%          0     1    20
%          0     0     1
%
%     % apply a rotation on a polygon
%     poly = [0 0; 30 0;30 10;10 10;10 20;0 20];
%     trans = createRotation([10 20], pi/6);
%     polyT = transformPoint(poly, trans);
%     % display the original and the rotated polygons
%     figure; hold on; axis equal; axis([-10 40 -10 40]);
%     drawPolygon(poly, 'k');
%     drawPolygon(polyT, 'b');
%
%
%   See also:
%   createTranslation, createRotation, createRotation90, createScaling
%   createHomothecy, createLineReflection, createBasisTransform
%   transformPoint, transformVector, transformLine, transformEdge
%   rotateVector, fitAffineTransform2d
%   polynomialTransform2d, fitPolynomialTransform2d

% ------
% Author: David Legland
% e-mail: david.legland@inra.fr
% Created: 2008-10-13,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2008 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

help('transforms2d');