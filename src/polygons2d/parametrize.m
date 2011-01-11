function par = parametrize(varargin)
%PARAMETRIZE return a parametrization of a curve
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
%   polylines2d, curveLength;
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2003.
%

px=0;
py=0;
if length(varargin)==1
    pts = varargin{1};
    px = pts(:,1);
    py = pts(:,2);
elseif length(varargin)==2
    px = varargin{1};
    py = varargin{2};
end

par = zeros(length(px), 1);
for p=2:length(px)
    par(p) = par(p-1)+ sqrt(power(px(p)-px(p-1),2) + ...
        power(py(p)-py(p-1),2) );
end


