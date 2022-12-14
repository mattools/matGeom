function poly2 = padPolyline(poly, M, varargin)
%PADPOLYLINE Add vertices at each extremity of the polyline.
%
%   POLY2 = padPolyline(POLY, M)
%   where M is a scalar, adds M vertices at the beginning and at the end of
%   the polyline. The number of vertices of the result polyline POLY2 is
%   equal to NV + 2*M. 
%
%   POLY2 = padPolyline(POLY, [M1 M2])
%   Adds M1 vertices at the beginning of the polyline, and M2 at the end.
%   The number of vertices of the result polyline POLY2 is NV + M1 + M2. 
%
%   POLY2 = padPolyline(..., 'method', METHOD)
%   Specifies the padding method to use. METHOD can be one of {'symetric'}
%   (the default), or 'repeat'.
%
%   Example
%     poly = circleArcToPolyline([50 50 30 30 80], 40);
%     poly2 = padPolyline(poly, 10, 'method', 'symetric');
%     figure; hold on; axis equal;
%     drawPolyline(poly, 'color', 'b', 'linewidth', 2);
%     drawPolyline(poly2, 'color', 'm')
%     legend({'Initial', 'Padded'}, 'Location', 'SouthWest');
%
%   See also 
%     polygons2d, smoothPolyline, polylineCurvature
%

% ------
% Author: David Legland
% E-mail: david.legland@inrae.fr
% Created: 2022-03-31, using Matlab 9.12.0.1884302 (R2022a)
% Copyright 2022 INRAE - BIA Research Unit - BIBS Platform (Nantes)

%% Input argument management

% default strategy
method = 'symetric';

% padding before and after
if isscalar(M)
    m1 = M;
    m2 = M;
else
    m1 = M(1);
    m2 = M(2);
end

% other parameter name-value pairs
while length(varargin) > 1
    name = varargin{1};
    if strcmpi(name, 'method')
        method = varargin{2};
    else
        error('Unknown argument name: %s', name);
    end
    varargin(1:2) = [];
end


%% Main Processing

% vertex number
nv = size(poly,1);

% switch processing depending on method
if strcmp(method, 'repeat')
    poly2 = [...
        poly(ones(m1,1), :) ; ...
        poly ;
        poly(nv * ones(m2,1), :) ; ...
        ];

elseif strcmp(method, 'symetric')
    v1 = poly(1,:);
    vn = poly(end,:);

     poly2 = [...
        2 * v1 - poly(m1+1:-1:2, :) ; ...
        poly ;
        2 * vn - poly(nv-1:-1:nv-m2, :) ; ...
        ];

else
    error('Unknown method name: %s', method);
end
