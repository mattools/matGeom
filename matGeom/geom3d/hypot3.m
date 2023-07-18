function h = hypot3(dx, dy, dz)
%HYPOT3 Diagonal length of a cuboidal 3D box .
%
%   h = hypot3(a, b, c)
%   computes the quantity sqrt(a^2 + b^2 + c^2), by avoiding roundoff
%   errors.
%
%   Example
%     % Compute diagonal of unit cube
%     hypot3(1, 1, 1)
%     ans =
%          1.7321
%
%     % Compute more complicated diagonal
%     hypot3(3, 4, 5)
%     ans = 
%         7.0711
%          
%   See also 
%   hypot, vectorNorm3d

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2012-04-29, using Matlab 7.9.0.529 (R2009b)
% Copyright 2012-2023 INRA - Cepia Software Platform

h = hypot(hypot(dx, dy), dz);
