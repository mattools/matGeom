function varargout = polynomialCurveCurvatures(t, varargin)
%POLYNOMIALCURVECURVATURES Compute curvatures of a polynomial revolution surface
%
%   KAPPAS = polynomialCurveCurvatures(T, XCOEF, YCOEF)
%   XCOEF and YCOEF are row vectors of coefficients, in the form:
%       [a0 a1 a2 ... an]
%   T is a column vector, containing the parametrization values for which
%   curvatures have to be computed.
%   KAPPAS is a matrix with 2 columns and as many rows as T, containing the
%   2 main curvatures for each specified T.
%   Curvatures are computed by assuming the curve to be rotated around the
%   vertical axis (from point (0,0), in direction (1,0)).
%
%   KAPPAS = polynomialCurveCurvatures(T, COEFS)
%   COEFS is either a 2xN matrix (one row for the coefficients of each
%   coordinate), or a cell array.
%
%   [KAPPA1 KAPPA2] = polynomialCurveCurvatures(...)
%   return the 2 main curvatures in separate arrays.
%
%   ... = polynomialCurveCurvatures(..., AXIS)
%   Specify the revolution axis. By default, revolution axis is the
%   vertical axis, going through point (0,0) and having direction vector
%   given by (0,1). Another axis of revolution can be specified in format:
%   AXIS = [x0 y0 dx dy].
%
%
%   See also
%   polynomialCurves2d, polynomialCurveCurvature
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-02-23
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.

%   HISTORY
%   28/02/2007 fix bug for the sign of the second curvature...
%   12/03/2007 base on vertical revolution axis, and adapt to manage any
%       revolution axis 


%% Extract input parameters

% polynomial coefficients for each coordinate
var = varargin{1};
if iscell(var)
    % coefficients are given in a cell array
    xCoef = var{1};
    yCoef = var{2};
    varargin(1)=[];
    
elseif size(var, 1) == 1
    % coefficients are given as two numeric vectors
    xCoef = varargin{1};
    yCoef = varargin{2};
    varargin(1:2)=[];
    
else
    % coefficients are given as a 2-by-N numeric array
    xCoef = var(1,:);
    yCoef = var(2,:);
    varargin(1)=[];
end

% revolution axis is the 2D vertical axis by default
axis = [0 0 0 1];
if ~isempty(varargin)
    axis = varargin{1};
end


%% Coordinate of curve points

% compute coordinates in original base
pts = polynomialCurvePoint(t, xCoef, yCoef);

% compute the matrix which transform points such that axis becomes the
% vertical axis
angle   = lineAngle(axis);
trans   = createRotation(axis(1:2), pi/2 - angle);

% transform points
pts = transformPoint(pts, trans);


%% compute first derivatives

% compute first derivatives of the polynomials
dx  = polynomialDerivate(xCoef);
dy  = polynomialDerivate(yCoef);

% compute local first derivatives
xp  = polyval(dx(end:-1:1), t);
yp  = polyval(dy(end:-1:1), t);

% transform vectors of first derivatives
vect = transformVector([xp yp], trans);
xp = vect(:,1);
yp = vect(:,2);


%% compute second derivatives

% compute second derivatives
sx  = polynomialDerivate(dx);
sy  = polynomialDerivate(dy);

% compute local second derivatives
xs  = polyval(sx(end:-1:1), t);
ys  = polyval(sy(end:-1:1), t);

% transform vectors of first derivatives
vect = transformVector([xs ys], trans);
xs = vect(:,1);
ys = vect(:,2);


%% computation of curvatures

% compute local curvatures of polynomial curve
kappa1  = sign(pts(:,1)) .* (xs.*yp - xp.*ys) ./ power(xp.*xp + yp.*yp, 3/2);
kappa2  = -yp ./ abs(pts(:,1)) ./ sqrt(xp.*xp + yp.*yp);


%% Format output arguments

if nargout < 2
    varargout{1} = [kappa1 kappa2];
else
    varargout{1} = kappa1;
    varargout{2} = kappa2;
end
