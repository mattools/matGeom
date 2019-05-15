function plane = medianPlane(p1, p2)
%MEDIANPLANE Create a plane in the middle of 2 points.
%
%   PLANE = medianPlane(P1, P2)
%   Creates a plane in the middle of 2 points.
%   PLANE is perpendicular to line (P1 P2) and contains the midpoint of P1
%   and P2.
%   The direction of the normal of PLANE is the same as the vector from P1
%   to P2.
%
%   See also:
%   planes3d, createPlane
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 18/02/2005.
%

%   HISTORY
%   28/06/2007: add doc, and manage multiple inputs

% unify data dimension
if size(p1, 1)==1
    p1 = repmat(p1, [size(p2, 1) 1]);
elseif size(p2, 1)==1
    p2 = repmat(p2, [size(p1, 1) 1]);
elseif size(p1, 1)~=size(p2, 1)    
    error('data should have same length, or one data should have length 1');
end

% middle point
p0  = (p1 + p2)/2;

% normal to plane
n   = p2-p1;

% create plane from point and normal
plane = createPlane(p0, n);