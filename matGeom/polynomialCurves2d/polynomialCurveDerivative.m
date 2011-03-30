function v = polynomialCurveDerivative(t, varargin)
%POLYNOMIALCURVEDERIVATIVE Compute derivative vector of a polynomial curve
%
%   VECT = polynomialCurveLength(T, XCOEF, YCOEF);
%   XCOEF and YCOEF are row vectors of coefficients, in the form:
%       [a0 a1 a2 ... an]
%   VECT is a 1x2 array containing direction of derivative of polynomial
%   curve, computed for position T. If T is a vector, VECT has as many rows
%   as the length of T.
%
%   VECT = polynomialCurveLength(T, COEFS);
%   COEFS is either a 2xN matrix (one row for the coefficients of each
%   coordinate), or a cell array.
%
%   Example
%   polynomialCurveDerivative
%
%   See also
%   polynomialCurves2d, polynomialCurveNormal, polynomialCurvePoint,
%   polynomialCurveCurvature 
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
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

% compute derivative of the polynomial
dx = polynomialDerivate(xCoef);
dy = polynomialDerivate(yCoef);

% convert to polyval convention
dx = dx(end:-1:1);
dy = dy(end:-1:1);

% numerical integration of the Jacobian of parametrized curve
v = [polyval(dx, t) polyval(dy, t)];

