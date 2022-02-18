%STEINERPOLYTOPE_DEMO  One-line description here, please.
%
%   output = steinerPolytope_demo(input)
%
%   Example
%   steinerPolytope_demo
%
%   See also
%
 
% ------
% Author: David Legland
% e-mail: david.legland@inrae.fr
% INRAE - BIA Research Unit - BIBS Platform (Nantes)
% Created: 2020-01-22,    using Matlab 9.7.0.1247435 (R2019b) Update 2
% Copyright 2020 INRAE.

vecList = [1 0 0; 0 1 0; 0 0 1; 1 1 1];
[v, f] = steinerPolytope(vecList);
figure; drawMesh(v, f);
axis equal; view([10 30]);

print(gcf, 'steinerPolytope.png', '-dpng');
