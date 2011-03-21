function pos = polynomialCurvePosition(tBounds, varargin)
%POLYNOMIALCURVEPOSITION Compute position on a curve for a given length
%
%   POS = polynomialCurvePosition(T, XCOEF, YCOEF, L)
%   XCOEF and YCOEF are row vectors of coefficients, in the form:
%       [a0 a1 a2 ... an]
%   T is a 1x2 row vector, containing the bounds of the parametrization
%   variable: T = [T0 T1], with T taking all values between T0 and T1.
%   L is the geodesic length corresponding to the searched position.
%   POS is a scalar, verifying relation:
%   L = polynomialCurveLength([T(1) POS], XCOEF, YCOEF);
%
%   POS = polynomialCurvePosition(T, COEFS, L)
%   COEFS is either a 2xN matrix (one row for the coefficients of each
%   coordinate), or a cell array.
%
%   POS = polynomialCurvePosition(..., TOL)
%   TOL is the tolerance fo computation (absolute).
%
%   See also
%   polynomialCurves2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-02-26
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

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

% geodesic length corresponding to searched position
L = varargin{1};
varargin(1)=[];

% tolerance
tol = 1e-6;
if ~isempty(varargin)
    tol = varargin{1};
end

% compute derivative of the polynomial
dx = polynomialDerivate(xCoef);
dy = polynomialDerivate(yCoef);

% convert to format of polyval
dx = dx(end:-1:1);
dy = dy(end:-1:1);

% avoid warning for t=0
warning off 'MATLAB:quad:MinStepSize'

% set up precision for t
options = optimset('TolX', tol);

% starting point, located in the middle of the paramtrization domain
ts = (t0+t1)/2;

% compute parameter corresponding to geodesic position by solving g(t)-tg=0
pos = fzero(@(t)funCurveLength(t0, t, dx, dy, tol)- L, ts, options);



function res = funCurveLength(t0, t1, c1, c2, varargin)
%FUNCURVELENGTH  return the length of polynomial curve arc
%   output = funCurveLength(t0, t1, c1, c2)
%   t0 and t1 are the limits of the integral
%   c1 and c2 are derivative polynoms of each coordinate parametrization,
%   given from greater order to lower order (polyval convention).
%   c1 = [an a_n-1 ... a2 a1 a0].
%
%   Example
%   funCurveLength(0, 1, C2, C2);
%   funCurveLength(0, 1, C2, C2, RES);
%   RES is the resolution (ex: 1e-6).
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-02-14
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

res = quad(@(t)sqrt(polyval(c1, t).^2+polyval(c2, t).^2), t0, t1, varargin{:});


