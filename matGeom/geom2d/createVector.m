function vect = createVector(p1, p2)
%CREATEVECTOR Create a vector from two points
%
%   V12 = createVector(P1, P2)
%   Creates the vector V12, defined as the difference between coordinates
%   of points P1 and P2.
%   P1 and P2 are row vectors with ND elements, ND being the space
%   dimension.
%
%   If one of the inputs is a N-by-Nd array, the other input is
%   automatically repeated, and the result is N-by-Nd.
%
%   If both inputs have the same size, the result also have the same size.
%
%
%   Example
%
%   See also
%   vectors2d, vectors3d, points2d
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-12-07,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

vect = bsxfun(@minus, p2, p1);
