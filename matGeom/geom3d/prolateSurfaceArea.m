function S = prolateSurfaceArea(elli, varargin)
%PROLATESURFACEAREA  Approximated surface area of a prolate ellipsoid
%
%   S = prolateSurfaceArea(R1,R2)
%
%   Example
%   prolateSurfaceArea
%
%   See also
%   geom3d, ellipsoidSurfaceArea, oblateSurfaceArea
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

assert(R1 > R2, 'first radius must be larger than second radius');

% surface theorique d'un ellipsoide prolate 
% cf http://fr.wikipedia.org/wiki/Ellipso%C3%AFde_de_r%C3%A9volution
e = sqrt(R1.^2 - R2.^2) ./ R1;
S = 2 * pi * R2.^2 + 2 * pi * R1 .* R2 .* asin(e) ./ e;
