function centroid = polynomialCurveCentroid(tBounds, varargin)
%POLYNOMIALCURVECENTROID Compute the centroid of a polynomial curve
%
%   C = polynomialCurveCentroid(T, XCOEF, YCOEF)
%   XCOEF and YCOEF are row vectors of coefficients, in the form:
%       [a0 a1 a2 ... an]
%   T is a 1x2 row vector, containing the bounds of the parametrization
%   variable: T = [T0 T1], with T taking all values between T0 and T1.
%   C contains coordinate of the polynomila curve centroid.
%
%   C = polynomialCurveCentroid(T, COEFS)
%   COEFS is either a 2xN matrix (one row for the coefficients of each
%   coordinate), or a cell array.
%
%   C = polynomialCurveCentroid(..., TOL)
%   TOL is the tolerance fo computation (absolute).
%
%   Example
%   polynomialCurveCentroid
%
%   See also
%   polynomialCurves2d, polynomialCurveLength
%
%
% ------
% Author: David Legland
% e-mail: david.legland@gignon.inra.fr
% Created: 2007-02-23
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


%% Extract input parameters

% parametrization bounds
t0 = tBounds(1);
t1 = tBounds(end);

% polynomial coefficients for each coordinate
var = varargin{1};
if iscell(var)
    xCoef = var{1};
    yCoef = var{2};
    varargin(1) = [];
elseif size(var, 1)==1
    xCoef = varargin{1};
    yCoef = varargin{2};
    varargin(1:2)=[];
else
    xCoef = var(1,:);
    yCoef = var(2,:);
    varargin(1)=[];
end
    
% tolerance
tol = 1e-6;
if ~isempty(varargin)
    tol = varargin{1};
end

%% compute length by numerical integration

% compute derivative of the polynomial
dx = polynomialDerivate(xCoef);
dy = polynomialDerivate(yCoef);

% convert to polyval format
dx = dx(end:-1:1);
dy = dy(end:-1:1);

cx = xCoef(end:-1:1);
cy = yCoef(end:-1:1);

% compute curve length by integrating the Jacobian
L = quad(@(t)sqrt(polyval(dx, t).^2+polyval(dy, t).^2), t0, t1, tol);

% compute first coordinate of centroid
xc = quad(@(t)polyval(cx, t).*sqrt(polyval(dx, t).^2+polyval(dy, t).^2), t0, t1, tol);

% compute first coordinate of centroid
yc = quad(@(t)polyval(cy, t).*sqrt(polyval(dx, t).^2+polyval(dy, t).^2), t0, t1, tol);

% divide result of integration by total length of the curve
centroid = [xc yc]/L;
