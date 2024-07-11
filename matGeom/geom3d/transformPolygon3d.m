function tfmPoly = transformPolygon3d(poly, tfm)
%TRANSFORMPOLYGON3D Transform a polygon with a 3D affine transform.
%
%   TFMPOLY = transformPolygon3d(POLY, TFM);
%   returns the polygon TFMPOLY by transforming POLY according to the
%   affine transform specified by TFM. POLY can be either 2D or 3D. If POLY
%   is 2D, zeros are added as third dimension, before the transformation is
%   performed.
%
%   Example
%     center=-100+200*rand(1,3);
%     phi=randi([-180,180]); theta=randi([-180,180]); psi=randi([-180,180]);
%     tfm=eulerAnglesToRotation3d(phi, theta, psi, 'ZYZ'); tfm(1:3,4)=center';
%     r = [2.5, 2, 1];
%     poly = flipud(circleToPolygon([0 0 r(1)], round(2*pi*r(1))));
%     midCircle = circleToPolygon([0 0 r(2)], round(2*pi*r(2)));
%     innerCircle = flipud(circleToPolygon([0 0 r(3)], round(2*pi*r(3))));
%     poly = {poly, midCircle, innerCircle};
%     tfmPoly = transformPolygon3d(poly, tfm);
%     figure('color','w'); axis equal; view(3)
%     drawPolygon3d(tfmPoly, 'r')
%
%   See also 
%     transforms3d, transformPoint3d, createTranslation3d
%     createRotationOx, createRotationOy, createRotationOz, createScaling
%

% ------
% Author: oqilipo
% E-mail: N/A
% Created: 2023-01-05, using MATLAB 9.13.0.2080170 (R2022b) Update 1
% Copyright 2023-2024

if isnumeric(poly)
    c = size(poly,2);
    if c < 2 || c > 3
        error(['The polygon has ' num2str(c) ' columns. A polygon must have either 2 or 3 columns!'])
    end
    tfmPoly = transformPoint3d(twoD2threeD(poly), tfm);
elseif iscell(poly)
    c = cellfun(@(x) size(x,2), poly);
    if all(c == 2) || all(c == 3)
        poly = cellfun(@twoD2threeD, poly, 'uni', 0);
        tfmPoly = cellfun(@(x) transformPoint3d(x, tfm), poly, 'uni', 0);
    else
        error(['The polygon has ' num2str(c) ' columns. A polygon must have either 2 or 3 columns!'])
    end
elseif isa(poly, 'polyshape')
    error('Polyshape format cannot be used for 3D polygons!')
else
    error('Unknown polygon format!')
end

end


function pts = twoD2threeD(pts)
if size(pts,2) == 2
    pts(:,3)=0;
    pts(isnan(pts(:,1)),3)=nan;
end
end
