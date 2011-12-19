function point = intersectLinePlane(line, plane)
%INTERSECTLINEPLANE Intersection point between a 3D line and a plane
%
%   PT = intersectLinePlane(LINE, PLANE)
%   Returns the intersection point of the given line and the given plane.
%   LINE:  [x0 y0 z0 dx dy dz]
%   PLANE: [x0 y0 z0 dx1 dy1 dz1 dx2 dy2 dz2]
%   PT:    [xi yi zi]
%   If LINE and PLANE are parallel, return [NaN NaN NaN].
%   If LINE (or PLANE) is a matrix with 6 (or 9) columns and N rows, result
%   is an array of points with N rows and 3 columns.
%   
%   See also:
%   lines3d, planes3d, points3d
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 17/02/2005.
%

%   HISTORY
%   24/11/2005 add support for multiple input
%   23/06/2006 correction from Songbai Ji
%   14/12/2006 correction for parallel lines and plane normals
%   05/01/2007 fixup for parallel lines and plane normals
%   24/04/2007 rename as 'intersectLinePlane'
%   11/19/2010 Added bsxfun functionality for improved speed (Sven Holcombe)

%  Songbai Ji (6/23/2006). Bug fixed; also allow one plane, many lines; 
% many planes one line; or N planes and N lines configuration in the input.

% unify sizes of data
plCnt = size(plane,1);
lnCnt = size(line,1);
if plCnt>1 && lnCnt>1 && plCnt~=lnCnt % N planes and M lines, not allowed for now.
    error('input size not correct, either one/many plane and many/one line, or same # of planes and lines!');
end

% plane normal
n = vectorCross3d(plane(:,4:6), plane(:,7:9));

% difference between origins of plane and line
dp = bsxfun(@minus, plane(:, 1:3), line(:, 1:3));

% relative position of intersection on line
t = sum(bsxfun(@times,n,dp),2)  ./  sum(bsxfun(@times,n,line(:,4:6)),2);

% compute coord of intersection point
point = bsxfun(@plus, line(:,1:3),  bsxfun(@times, [t t t], line(:,4:6)));

% set indices of line and plane which are parallel to NaN
par = abs( sum(bsxfun(@times, n, line(:,4:6)), 2) ) < 1e-14;
point(par,:) = NaN;
