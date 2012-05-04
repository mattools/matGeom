function varargout = orientedBoxToPolygon(obox)
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
%   See also:
%   polygons2d, orientedBox, drawOrientedBox, drawPolygon
%
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 06/04/2005.
%

%   HISTORY
%   2011-10-09 rewrite from rectAsPolygon to orientedBoxToPolygon

% extract box parameters
theta = 0;
x   = obox(1);
y   = obox(2);
hw  = obox(3) / 2;  % easier to compute with w and h divided by 2
hh  = obox(4) / 2;
if length(obox) > 4
    theta = obox(5);
end

% pre-compute angles
cot = cosd(theta);
sit = sind(theta);

% precompute shifts
wc = hw * cot;
ws = hw * sit;
hc = hh * cot;
hs = hh * sit;

% allocate memory
tx = zeros(4, 1);
ty = zeros(4, 1);

% compute 
tx(1) = x - wc + hs;
ty(1) = y - ws - hc;
tx(2) = x + wc + hs;
ty(2) = y + ws - hc;
tx(3) = x + wc - hs;
ty(3) = y + ws + hc;
tx(4) = x - wc - hs;
ty(4) = y - ws + hc;

% format output
if nargout <= 1
    varargout = {[tx ty]};
elseif nargout == 2
    varargout = {tx, ty};
end
