function S = oblateSurfaceArea(elli, varargin)
%OBLATESURFACEAREA  Approximated surface area of an oblate ellipsoid.
%
%   S = oblateSurfaceArea(R1,R2)
%
%   Example
%   oblateSurfaceArea
%
%   See also
%   geom3d, ellipsoidSurfaceArea, prolateSurfaceArea
%

% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2015-07-03,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2015 INRA - Cepia Software Platform.

%% Parse input argument

if size(elli, 2) == 7
    R1 = elli(:, 4);
    R2 = elli(:, 5);
    
elseif size(elli, 2) == 1 && ~isempty(varargin)
    R1 = elli(:, 1);
    R2 = varargin{1};
end

assert(R1 < R2, 'First radius must be smaller than second radius'); 

% surface theorique d'un ellipsoide oblate 
% cf http://fr.wikipedia.org/wiki/Ellipso%C3%AFde_de_r%C3%A9volution
e = sqrt(R2.^2 - R1.^2) ./ R2;
S = 2 * pi * R2.^2 + pi * R1.^2 * log((1 + e) ./ (1 - e)) ./ e;
