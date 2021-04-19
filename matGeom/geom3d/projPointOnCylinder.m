function ptProj = projPointOnCylinder(pt, cyl, varargin)
%PROJPOINTONCYLINDER Project a 3D point onto a cylinder.
%
%   PTPROJ = projPointOnCircle3d(PT, CYLINDER).
%   Computes the projection of 3D point PT onto the CYLINDER. 
%   
%   Point PT is a 1-by-3 array, and CYLINDER is a 1-by-7 array.
%   Result PTPROJ is a 1-by-3 array, containing the coordinates of the
%   projection of PT onto the CYLINDER.
%
%   PTPROJ = projPointOnCircle3d(..., OPT)
%   with OPT = 'open' (0) (default) or 'closed' (1), specify if the bases 
%   of the cylinder should be included.
%
%   Example
%       demoProjPointOnCylinder
%
%   See also
%       projPointOnLine3d, projPointOnPlane, projPointOnCircle3d
%

% ---------
% Author: oqilipo
% Created: 2021-04-17, using R2020b
% Copyright 2021

parser = inputParser;
addRequired(parser, 'pt', @(x) validateattributes(x, {'numeric'},...
    {'size',[1 3],'real','finite','nonnan'}));
addRequired(parser, 'cyl', @(x) validateattributes(x, {'numeric'},...
    {'size',[1 7],'real','finite','nonnan'}));
capParValidFunc = @(x) (islogical(x) ...
    || isequal(x,1) || isequal(x,0) || any(validatestring(x, {'open','closed'})));
addOptional(parser,'cap','open', capParValidFunc);
parse(parser,pt,cyl,varargin{:});
pt = parser.Results.pt;
cyl = parser.Results.cyl;
cap = lower(parser.Results.cap(1));

% Radius of the cylinder
cylRadius = cyl(7);
% Height of the cylinder
cylBottom = -Inf;
cylHeight = Inf;
if cap == 'c' || cap == 1
    cylBottom = 0;
    cylHeight = distancePoints3d(cyl(1:3),cyl(4:6));
end
% Create a transformation for the point into a local cylinder coordinate 
% system. Align the cylinder axis with the z axis and translate the 
% starting point of the cylinder to the origin.
TFM = createRotationVector3d(cyl(4:6)-cyl(1:3), [0 0 1])*createTranslation3d(-cyl(1:3));
% cylTfm = [transformPoint3d(cyl(1:3), TFM) transformPoint3d(cyl(4:6), TFM) cylRadius];
% cylTfm2 = [0 0 0 0 0 cylHeight, cylRadius];
% assert(ismembertol(cylTfm,cylTfm2,'byRows',1,'DataScale',1e1))

% Transform the point.
ptTfm = transformPoint3d(pt,TFM);
% Convert the transformed point to cylindrical coordinates.
[ptTheta, ptRadius, ptHeight] = cart2cyl(ptTfm);

if ptRadius <= cylRadius && (ptHeight <= cylBottom || ptHeight >= cylHeight)
    % If point is inside the radius of the cylinder but outside its height
    if ptHeight <= cylBottom
        ptProj_cyl = [ptTheta, ptRadius, 0];
    else
        ptProj_cyl = [ptTheta, ptRadius, cylHeight];
    end
elseif ptRadius > cylRadius && (ptHeight <= cylBottom || ptHeight >= cylHeight)
    % If point is outside the cylinder's radius and height
    if ptHeight <= cylBottom
        ptProj_cyl = [ptTheta, cylRadius, 0];
    else
        ptProj_cyl = [ptTheta, cylRadius, cylHeight];
    end
elseif ptRadius < cylRadius && (ptHeight > cylBottom && ptHeight < cylHeight)
    % If point is inside the cylinder's radius and height
    deltaRadius = cylRadius - ptRadius;
    deltaHeight = cylHeight - ptHeight;
    if (deltaRadius < ptHeight && deltaRadius < deltaHeight) || isinf(cylBottom)
        % If the distance to the cylinder's surface is smaller than the
        % distance to the top and bottom surfaces.
        ptProj_cyl = [ptTheta, cylRadius, ptHeight];
    else
        if ptHeight < deltaHeight
            ptProj_cyl = [ptTheta, ptRadius, 0];
        else
            ptProj_cyl = [ptTheta, ptRadius, cylHeight];
        end
    end
elseif ptRadius >= cylRadius && (ptHeight > cylBottom && ptHeight < cylHeight)
    % If point is outside the radius of the cylinder and inside its height
    ptProj_cyl = [ptTheta, cylRadius, ptHeight];
end

% Convert the projected point back to Cartesian coordinates 
ptProj_cart = cyl2cart(ptProj_cyl);
% Transform the projected point back to the global coordinate system
ptProj = transformPoint3d(ptProj_cart,inv(TFM));

end