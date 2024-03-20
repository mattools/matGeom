function ray = createRay3d(p1, p2)
%CREATERAY3D Create a 3D ray.
%
%   RAY = createRay3d(P1, P2)
%   Create a ray starting from point P1 and going in the direction of point
%   P2.
%
%   Example
%   createRay3d
%
%   See also 
%     creatLine3d

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2020-05-25, using Matlab 9.8.0.1323502 (R2020a)
% Copyright 2020-2023 INRAE - BIA Research Unit - BIBS Platform (Nantes)

ray = [p1 (p2-p1)];
