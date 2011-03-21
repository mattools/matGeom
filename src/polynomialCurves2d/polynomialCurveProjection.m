function pos = polynomialCurveProjection(tBounds, varargin)
%POLYNOMIALCURVEPROJECTION Projection of a point on a polynomial curve
%
%   T = polynomialCurveProjection([T0 T1], XCOEFS, YCOEFS, POINT); 
%   Computes the position of POINT on the polynomial curve, such that 
%   polynomialCurvePoint([T0 T1], XCOEFS, YCOEFS) is the same as POINT.
%
%   See also
%   polynomialCurves2d, polynomialCurvePoint
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-12-21
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


% the point to project
point = varargin{1};
varargin(1)=[];

% tolerance
tol = 1e-6;
if ~isempty(varargin)
    tol = varargin{1};
end

% update coefficient according to point position
xCoef(1) = xCoef(1) - point(1);
yCoef(1) = yCoef(1) - point(2);

% convert to format of polyval
c1 = xCoef(end:-1:1);
c2 = yCoef(end:-1:1);

% avoid warning for t=0
warning off 'MATLAB:quad:MinStepSize'

% set up precision for t
options = optimset('TolX', tol^2);

% compute minimisation of the distance function
pos = fminbnd(@(t) polyval(c1, t).^2+polyval(c2, t).^2, t0, t1, options);
