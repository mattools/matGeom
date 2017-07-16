function T = createHomothecy(point, ratio)
%CREATEHOMOTHECY Create the the 3x3 matrix of an homothetic transform
%
%   TRANS = createHomothecy(POINT, K);
%   POINT is the center of the homothecy, K is its factor.
%   TRANS is a 3-by-3 matrix representing the homothetic transform in
%   homogeneous coordinates.
%
%   Example:
%
%      p  = [0 0; 1 0; 0 1];
%      s  = [-0.5 0.4];
%      T  = createHomothecy (s, 1.5);
%      pT = transformPoint (p, T);
%      drawPolygon (p,'-b')
%      hold on;
%      drawPolygon (pT, '-r');
%      
%      drawEdge (p(:,1), p(:,2), pT(:,1), pT(:,2), ...
%                'color', 'k','linestyle','--')
%      hold off
%      axis tight equal
%

% ---------
% Author: David Legland
% e-mail: david.legland@inra.fr
% INRA - TPV URPOI - BIA IMASTE
% created the 20/01/2005.


%   HISTORY
%   22/04/2009: rename as createHomothecy
%   05/04/2017: improved code by JuanPi Carbajal <ajuanpi+dev@gmail.com>

point = point(:);
if length (point) > 2
    error('Only one point accepted.');
end
if length (ratio) > 1
    error('Only one ratio accepted.');
end

T        = diag ([ratio ratio 1]);
T(1:2,3) = point .* (1 - ratio);
