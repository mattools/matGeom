function coord = planePoint(plane, point)
%PLANEPOINT Compute 3D position of a point in a plane
%
%   POINT = planePoint(PLANE, POS)
%   PLANE is a 9 element row vector [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   POS is the coordinate of a point in the plane basis,
%   POINT is the 3D coordinate in global basis.
%
%   Example
%   planePoint
%
%   See also
%   planes3d, planePosition
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-09-18,    using Matlab 7.4.0.287 (R2007a)
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% adapt size of input arguments
npl = size(plane, 1);
npt = size(point, 1);
if npl~=npt
    if npl==1
        plane = repmat(plane, npt, 1);
    elseif npt==1
        point = repmat(point, npl, 1);
    else
        error('plane and point should have same size');
    end
end

% compute 3D coordinate
coord = plane(:,1:3) + ...
    plane(:,4:6).*repmat(point(:,1), 1, 3) + ...
    plane(:,7:9).*repmat(point(:,2), 1, 3);
