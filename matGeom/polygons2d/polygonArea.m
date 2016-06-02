function area = polygonArea(poly, varargin)
%POLYGONAREA Compute the signed area of a polygon
%
%   A = polygonArea(POINTS);
%   Compute area of a polygon defined by POINTS. POINTS is a N-by-2 array
%   of double containing coordinates of vertices.
%   
%   Vertices of the polygon are supposed to be oriented Counter-Clockwise
%   (CCW). In this case, the signed area is positive.
%   If vertices are oriented Clockwise (CW), the signed area is negative.
%
%   If polygon is self-crossing, the result is undefined.
%
%   If the polygon contains holes (separated by nans) the result is well defined
%   only when the outer polygon is oriented CCW and the holes are oriented CW.
%   In this case the result is the sum of the signed areas.
%
%   If the input is a cell, each element is considered a polygon and the area
%   of each one is returned in the matrix that has the same shape as the cell.
%
%   Examples
%     % compute area of a simple shape
%     poly = [10 10;30 10;30 20;10 20];
%     area = polygonArea(poly)
%     area = 
%         200
%
%     % compute area of CW polygon
%     area2 = polygonArea(poly(end:-1:1, :))
%     area2 = 
%         -200
%
%     % Computes area of a paper hen
%     x = [0 10 20  0 -10 -20 -10 -10  0];
%     y = [0  0 10 10  20  10  10  0 -10];
%     poly = [x' y'];
%     area = polygonArea(poly)
%     area =
%        400
%
%     % Area of square with hole
%     pccw = pcw = [0 0; 1 0; 1 1; 0 1];
%     pcw([2 4],:) = pcw([4 2], :);
%     polygonArea ([pc; nan(1,2); 0.5*pcw+[0.25 0.25]])
%     ans =
%        0.75
%
%   References
%   algo adapted from P. Bourke web page
%   http://paulbourke.net/geometry/polygonmesh/
%
%   See also:
%   polygons2d, polygonCentroid, drawPolygon, triangleArea
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 05/05/2004.

%   HISTORY
%   25/04/2005: add support for multiple polygons
%   12/10/2007: update doc
%   29/05/2016: Simplified code and handled holes (by JuanPi Carbajal)

function A = polygonArea(px, py)

    % in case of polygon sets, computes several areas
    if iscell (px)
         A = cellfun (@func, px);
    else

        if nargin == 2
            px = [px py];
        end
        A = func (px);
    end

end

function a = func (c)

    if any (isnan (c))
        cc = splitPolygons (c);
        a  = cellfun (@func, cc);
        a  = sum (a);
    else
        N = size (c, 1);
        if N < 3
            a = 0;
        else
            iNext = [2:N 1];
            a     = sum (c(:,1) .* c(iNext,2) - c(iNext,1) .* c(:,2)) / 2;
        end
    end

end
