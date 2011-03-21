function kappa = polynomialCurveCurvature(t, varargin)
%POLYNOMIALCURVECURVATURE Compute the local curvature of a polynomial curve
%
%   KAPPA = polynomialCurveCurvature(T, XCOEF, YCOEF)
%   XCOEF and YCOEF are row vectors of coefficients, in the form:
%       [a0 a1 a2 ... an]
%   KAPPA is the local curvature of the polynomial curve, computed for
%   position T. If T is a vector, KAPPA has the same length as T.
%
%   KAPPA = polynomialCurveCurvature(T, COEFS)
%   COEFS is either a 2xN matrix (one row for the coefficients of each
%   coordinate), or a cell array.
%
%   Example
%   polynomialCurveCurvature
%
%   See also
%   polynomialCurves2d, polynomialCurveLength, polynomialCurveDerivative
%
%
% ------
% Author: David Legland
% e-mail: david.legland@nantes.inra.fr
% Created: 2007-02-23
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

%% Extract input parameters

% polynomial coefficients for each coordinate
var = varargin{1};
if iscell(var)
    xCoef = var{1};
    yCoef = var{2};
elseif size(var, 1)==1
    xCoef = varargin{1};
    yCoef = varargin{2};
else
    xCoef = var(1,:);
    yCoef = var(2,:);
end
    

%% compute derivative

% compute first derivatives of the polynomials
dx  = polynomialDerivate(xCoef);
dy  = polynomialDerivate(yCoef);

% compute second derivatives
sx  = polynomialDerivate(dx);
sy  = polynomialDerivate(dy);

% convert to polyval convention
dx  = dx(end:-1:1);
dy  = dy(end:-1:1);
sx  = sx(end:-1:1);
sy  = sy(end:-1:1);

% compute local first and second derivatives
xp  = polyval(dx, t);
yp  = polyval(dy, t);
xs  = polyval(sx, t);
ys  = polyval(sy, t);

% compute local curvature of polynomial curve
kappa  = (xp.*ys - xs.*yp) ./ power(xp.*xp + yp.*yp, 3/2);

