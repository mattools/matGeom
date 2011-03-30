function point = polynomialCurvePoint(t, varargin)
%POLYNOMIALCURVEPOINT Compute point corresponding to a position
%
%   POINT = polynomialCurvePoint(T, XCOEF, YCOEF)
%   XCOEF and YCOEF are row vectors of coefficients, in the form:
%       [a0 a1 a2 ... an]
%   T is a either a scalar, or a column vector, containing values of the
%   parametrization variable.
%   POINT is a 1x2 array containing coordinate of point corresponding to
%   position given by T. If T is a vector, POINT has as many rows as T.
%
%   POINT = polynomialCurvePoint(T, COEFS)
%   COEFS is either a 2xN matrix (one row for the coefficients of each
%   coordinate), or a cell array.
%
%   Example
%   polynomialCurvePoint
%
%   See also
%   polynomialCurves2d, polynomialCurveLength
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
    

%% compute length by numerical integration

% convert polynomial coefficients to polyval convention
cx = xCoef(end:-1:1);
cy = yCoef(end:-1:1);

% numerical integration of the Jacobian of parametrized curve
point = [polyval(cx, t) polyval(cy, t)];

