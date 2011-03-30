function v = polynomialCurveNormal(t, varargin)
%POLYNOMIALCURVENORMAL Compute the normal of a polynomial curve
%
%   N = polynomialCurveNormal(T, XCOEF, YCOEF)
%   XCOEF and YCOEF are row vectors of coefficients, in the form:
%       [a0 a1 a2 ... an]
%   T is a 1x2 row vector, containing the bounds of the parametrization
%   variable: T = [T0 T1], with T taking all values between T0 and T1.
%   T can also be a larger vector, in this case only bounds are kept.
%   N is a 1x2 row vector, containing direction of curve normal in T.
%   If T is column vector, the result is a matrix with 2 columns containing
%   normal vector for each position.
%
%   The normal is oriented such that oriented angle from derivative
%   vector to normal vector equals PI/2. The normal points to the 'left'
%   when travelling along the curve.

%   N = polynomialCurveNormal(T, COEFS)
%   COEFS is either a 2xN matrix (one row for the coefficients of each
%   coordinate), or a cell array.
%
%   N = polynomialCurveNormal(..., TOL)
%   TOL is the tolerance fo computation (absolute).
%
%   Example
%   polynomialCurveNormal
%
%   See also
%   polynomialCurves2d, polynomialCurveDerivative
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-02-23
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

% extract the derivative
v = polynomialCurveDerivative(t, varargin{:});

% rotate by PI/2 Counter clockwise
v = [-v(:,2) v(:,1)];
