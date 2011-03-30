function trans = createHomothecy(point, ratio)
%CREATEHOMOTHECY Create the the 3x3 matrix of an homothetic transform
%
%   TRANS = createHomothecy(POINT, K);
%   POINT is the center of the homothecy, K is its factor.
%
%   See also:
%   transforms2d, transformPoint, createTranslation
%
%   ---------
%   author : David Legland 
%   INRA - TPV URPOI - BIA IMASTE
%   created the 20/01/2005.
%

%   HISTORY
%   22/04/2009: rename as createHomothecy

% extract coordinate of center
x0 = point(:,1);
y0 = point(:,2);

% compute coefficients of the matrix
m00 = ratio;
m01 = 0;
m02 = x0*(1-ratio);
m10 = 0;
m11 = ratio;
m12 = y0*(1-ratio);

% create transformation
trans = [m00 m01 m02; m10 m11 m12; 0 0 1];
