function varargout = drawPolynomialCurve(tBounds, varargin)
%DRAWPOLYNOMIALCURVE Draw a polynomial curve approximation
%
%   Usage
%   drawPolynomialCurve(BND, XCOEFS, YCOEFS)
%   drawPolynomialCurve(BND, XCOEFS, YCOEFS, NPTS)
%
%   Example
%   drawPolynomialCurve
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2011-03-21,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2011 INRA - Cepia Software Platform.


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
    varargin(1:2) = [];
    
else
    xCoef = var(1,:);
    yCoef = var(2,:);
    varargin(1) = [];
end

nPts = 120;
if ~isempty(varargin)
    nPts = varargin{1};
end


%% Drawing the polyline approximation

% generate vector of absissa
t = linspace(t0, t1, nPts+1)';

% compute corresponding positions
pts = polynomialCurvePoint(t, xCoef, yCoef);

% draw the resulting curve
h = drawPolyline(pts);

if nargout > 0
    varargout = {h};
end
