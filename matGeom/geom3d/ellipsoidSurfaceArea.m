function s = ellipsoidSurfaceArea(elli)
%ELLIPSOIDSURFACEAREA  Approximated surface area of an ellipsoid.
%
%   S = ellipsoidSurfaceArea(ELLI)
%   Computes an approximation of the surface area of an ellipsoid. 
%   ELLI is a 1-by-9 row vector given by [XC YC ZC A B C THETA PHI PSI],
%   where (XC YC ZC) is the center, (A B C) is the length of each semi axis
%   and (THETA PHI PSI) representes the orientation.
%   If ELLI is a 1-by-3 row vector, it is assumed to contain only the
%   lengths of semi-axes.
%
%   This functions computes an approximation of the surface area, given by:
%   S = 4 * pi * ( (a^p * b^p + a^p * c^p + b^p * c^p) / 3) ^ (1/p)
%   with p = 1.6075. The resulting error should be less than 1.061%.
%
%   Example
%   ellipsoidSurfaceArea
%
%   See also
%   geom3d, ellipsePerimeter, oblateSurfaceArea, prolateSurfaceArea
%
%   References
%   * http://en.wikipedia.org/wiki/Ellipsoid
%   * http://mathworld.wolfram.com/Ellipsoid.html
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2012-02-24,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2012 INRA - Cepia Software Platform.

%% Parse input argument

if size(elli, 2) == 9
    a = elli(:, 4);
    b = elli(:, 5);
    c = elli(:, 6);
    
elseif size(elli, 2) == 3
    a = elli(:, 1);
    b = elli(:, 2);
    c = elli(:, 3);    
end

p = 1.6075;
s = 4 * pi * ( (a.^p .* b.^p + a.^p .* c.^p + b.^p .* c.^p) / 3) .^ (1 / p);
