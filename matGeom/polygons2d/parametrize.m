function par = parametrize(varargin)
%PARAMETRIZE Compute a parametrization of a curve, based on geodesic length
%
%   PAR = PARAMETRIZE(POINTS)
%   return a parametrization of the curve defined by the serie of points,
%   based on euclidean distance between two consecutive points. POINTS is a
%   [N*2] array, and PAR is [N*1].
%
%   PAR = PARAMETRIZE(PX, PY)
%   is the same, but specify points coordinates in separate arrays.
%
%
%   TODO: add normalization option (result between 0 and 1).
%   
%   See also:
%   polylines2d, polylineLength
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2003.
%

% extract vertex coordinates
if length(varargin)==1
    % points in a single array
    pts = varargin{1};
    px = pts(:,1);
    py = pts(:,2);
    
elseif length(varargin)==2
    % points as separate arrays
    px = varargin{1};
    py = varargin{2};
end

% compute cumulative sum of euclidean distances between consecutive
% vertices, setting distance of first vertex to 0.
par = [0 ; cumsum(hypot(diff(px), diff(py)))];

% % Previous version:
% % allocate memory
% par = zeros(length(px), 1);
% for p=2:length(px)
%     par(p) = par(p-1)+ sqrt(power(px(p)-px(p-1),2) + ...
%         power(py(p)-py(p-1),2) );
% end


