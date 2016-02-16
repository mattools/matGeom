function [tx, ty] = orientedBoxToPolygon(obox)
%ORIENTEDBOXTOPOLYGON Convert an oriented box to a polygon (set of vertices)
%
%   POLY = orientedBoxToPolygon(OBOX);
%   Converts the oriented box OBOX given either as [XC YC W H] or as 
%   [XC YC W H THETA] into a 4-by-2 array of double, containing coordinates
%   of box vertices. 
%   XC and YC are center of the box. W and H are the width and the height
%   (dimension in the main directions), and THETA is the orientation, in
%   degrees between 0 and 360.
%
%   Example
%     OBOX = [20 10  40 20 0];
%     RECT = orientedBoxToPolygon(OBOX)
%     RECT =
%         -20 -10 
%          20 -10 
%          20  10 
%         -20  10 
%
%
%   See also:
%   polygons2d, orientedBox, drawOrientedBox, rectToPolygon
%

%   ---------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% INRA - TPV URPOI - BIA IMASTE
% created the 06/04/2005.
%

%   HISTORY
%   2011-10-09 rewrite from rectAsPolygon to orientedBoxToPolygon
%   2016: Simplify by JuanPi Carbajal

% extract box parameters
theta = 0;
x = obox(1);
y = obox(2);
w = obox(3) / 2;  % easier to compute with w and h divided by 2
h = obox(4) / 2;
if length(obox) > 4
    theta = obox(5);
end

v = [cosd(theta); sind(theta)];
M = bsxfun (@times, [-1 1; 1 1; 1 -1; -1 -1], [w h]);
tx  = x + M * v;
ty  = y + M(4:-1:1,[2 1]) * v;

if nargout <= 1
  tx = [tx ty];
end