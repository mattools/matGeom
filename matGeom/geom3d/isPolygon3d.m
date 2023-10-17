function a = isPolygon3d(pol, varargin)
%ISPOLYGON3D Check if input is a 3d polygon.
%
%   B = isPolygon3d(POL) where POL should be a 3d polygon.
%
%   Example:
%     % 2d polygon
%     pol = [6	7	6	6	5	4	3	2	2	1	2	2	6	6 ...
%            NaN  3	3	4	5	5	3	3	NaN	4	5	5	4;
%            4	4	5	6	6	7	6	6	4	2	2	2	1	4 ...
%    	     NaN  4	5	5	4	4	3	4	NaN	3	2	3	3]';
%     % 3d random transformation
%     phi=-360+720*rand;
%     theta=-360+720*rand;
%     psi=-360+720*rand;
%     % 3d polygon
%     pol3d = transformPolygon3d(pol, eulerAnglesToRotation3d(phi, theta, psi));
%     disp('Valid 3d polygon')
%     disp(['Is 3d polygon?: ' num2str(isPolygon3d(pol3d))])
%     disp('2d polygon, not 3d')
%     disp(['Is 3d polygon?: ' num2str(isPolygon3d(pol))])
%     pol3d2 = pol3d; pol3d2(12) = pol3d2(12)+1e-12;
%     disp('Not all points in same plane')
%     disp(['Is 3d polygon?: ' num2str(isPolygon3d(pol3d2))])
%     disp('Not real, contains complex elements')
%     pol3d3 = pol3d; pol3d3(12) = pol3d3(12)+4i;
%     disp(['Is 3d polygon?: ' num2str(isPolygon3d(pol3d3))])
%
%   See also 
%   polygons3d

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-10-15, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023

narginchk(1,2)

parser = inputParser;
addOptional(parser,'tolerance',1e-14, ...
    @(x) validateattributes(x,{'numeric'},{'scalar','>',0,'<',1}))
parse(parser, varargin{:});
TOL = parser.Results.tolerance;

polRep = parsePolygon(pol,'repetition');

% Dimensions of the 3d polygon should be [Nx3].
if size(polRep,2)~=3
    a=false;
    return
end

% All points must be located in the same plane.
polPlane = fitPlane(polRep);
if any(abs(distancePointPlane(polRep, polPlane)) > TOL)
    a=false;
    return
end

b = ~any(isinf(polRep(:)));
c = isreal(polRep);

a = b & c;

end
