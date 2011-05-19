function varargout = polynomialCurveFit(t, varargin)
%POLYNOMIALCURVEFIT Fit a polynomial curve to a series of points
%
%   [XC YC] = polynomialCurveFit(T, XT, YT, ORDER)
%   T is a Nx1 vector
%   XT and YT are coordinate for each parameter value (column vectors)
%   ORDER is the degree of the polynomial used for interpolation
%   XC and YC are polynomial coefficients, given in ORDER+1 row vectors,
%   starting from degree 0 and up to degree ORDER.
%
%	[XC YC] = polynomialCurveFit(T, POINTS, ORDER);
%   specifies coordinate of points in a Nx2 array.
%
%   Example:
%   N = 50;
%   t = linspace(0, 3*pi/4, N)';
%   xp = cos(t); yp = sin(t);
%   [xc yc] = polynomialCurveFit(t, xp, yp, 3);
%   curve = polynomialCurvePoint(t, xc, yc);
%   drawCurve(curve);
%
%
%	[XC YC] = polynomialCurveFit(..., T_I, COND_I);
%   Impose some specific conditions. T_I is a value of the parametrization
%   variable. COND_I is a cell array, with 2 columns, and as many rows as
%   the derivatives specified for the given T_I. Format for COND_I is:
%   COND_I = {X_I, Y_I; X_I', Y_I'; X_I", Y_I"; ...};
%   with X_I and Y_I being the imposed coordinate at position T_I, X_I' and
%   Y_I' being the imposed first derivatives, X_I" and Y_I" the imposed
%   second derivatives, and so on...
%   To specify a derivative without specifying derivative with lower
%   degree, value of lower derivative can be let empty, using '[]'
%
%   Example:
%   % defines a curve (circle arc) with small perturbations
%   N = 100;
%   t = linspace(0, 3*pi/4, N)';
%   xp = cos(t)+.1*randn(size(t)); yp = sin(t)+.1*randn(size(t));
%   
%   % plot the points
%   figure(1); clf; hold on;
%   axis([-1.2 1.2 -.2 1.2]); axis equal;
%   drawPoint(xp, yp);
%
%   % fit without knowledge on bounds
%   [xc0 yc0] = polynomialCurveFit(t, xp, yp, 5);
%   curve0 = polynomialCurvePoint(t, xc0, yc0);
%   drawCurve(curve0);
%
%   % fit by imposing coordinate on first point
%   [xc1 yc1] = polynomialCurveFit(t, xp, yp, 5, 0, {1, 0});
%   curve1 = polynomialCurvePoint(t, xc1, yc1);
%   drawCurve(curve1, 'r');
%
%   % fit by imposing coordinate (1,0) and derivative (0,1) on first point
%   [xc2 yc2] = polynomialCurveFit(t, xp, yp, 5, 0, {1, 0;0 1});
%   curve2 = polynomialCurvePoint(t, xc2, yc2);
%   drawCurve(curve2, 'g');
%
%   % fit by imposing several conditions on various points
%   [xc3 yc3] = polynomialCurveFit(t, xp, yp, 5, ...
%       0, {1, 0;0 1}, ...      % coord and first derivative of first point
%       3*pi/4, {-sqrt(2)/2, sqrt(2)/2}, ...    % coord of last point
%       pi/2, {[], [];-1, 0});      % derivative of point on the top of arc
%   curve3 = polynomialCurvePoint(t, xc3, yc3);
%   drawCurve(curve3, 'k');
%
%   Requires the optimization Toolbox.
%
%
%   Examples:
%   polynomialCurveFit
%
%   See also
%   polynomialCurves2d
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2007-02-27
% Copyright 2007 INRA - BIA PV Nantes - MIAJ Jouy-en-Josas.


%% extract input arguments

% extract curve coordinate
var = varargin{1};
if min(size(var))==1
    % curve given as separate arguments
    xt = varargin{1};
    yt = varargin{2};
    varargin(1:2)=[];
else
    % curve coordinate bundled in a matrix
    if size(var, 1)<size(var, 2)
        var = var';
    end
    xt = var(:,1);
    yt = var(:,2);
    varargin(1)=[];
end

% order of the polynom
var = varargin{1};
if length(var)>1
    Dx = var(1);
    Dy = var(2);
else
    Dx = var;
    Dy = var;
end
varargin(1)=[];


%% Initialize local conditions

% For a solution vector 'x', the following relation must hold:
%   Aeq * x == beq,
% with:
%   Aeq   Matrix M*N 
%   beq   column vector with length M
% The coefficients of the Aeq matrix are initialized as follow:
% First point and last point are considered successively. For each point,
% k-th condition is the value of the (k-1)th derivative. This value is
% computed using relation of the form:
%   value = sum_i ( fact(i) * t_j^pow(i) )
% with:
%   i     indice of the (i-1) derivative. 
%   fact  row vector containing coefficient of each power of t, initialized
%       with a row vector equals to [1 1 ... 1], and updated for each
%       derivative by multiplying by corresponding power minus 1.
%   pow   row vector of the powers of each monome. It is represented by a
%       row vector containing an increasing series of power, eventually
%       completed with zeros for lower degrees (for the k-th derivative,
%       the coefficients with power lower than k are not relevant).

% Example for degree 5 polynom:
%   iter deriv  pow                 fact
%   1    0      [0 1 2 3 4 5]       [1 1 1 1 1 1]
%   2    1      [0 0 1 2 3 4]       [0 1 2 3 4 5]
%   3    2      [0 0 0 1 2 3]       [0 0 1 2 3 4]
%   4    3      [0 0 0 0 1 2]       [0 0 0 1 2 3]
%   ...
%   The process is repeated for coordinate x and for coordinate y.

% Initialize empty matrices
Aeqx = zeros(0, Dx+1);
beqx = zeros(0, 1);
Aeqy = zeros(0, Dy+1);
beqy = zeros(0, 1);

% Process local conditions
while ~isempty(varargin)
    if length(varargin)==1
        warning('MatGeom:PolynomialCurveFit:ArgumentNumber', ...
            'Wrong number of arguments in polynomialCurvefit');
    end

    % extract parameter t, and cell array of local conditions
    ti = varargin{1};
    cond = varargin{2};

    % factors for coefficients of each polynomial. At the beginning, they
    % all equal 1. With successive derivatives, their value increase by the
    % corresponding powers.
    factX = ones(1, Dx+1);
    factY = ones(1, Dy+1);

    % start condition initialisations
    for i = 1:size(cond, 1)
        % degrees of each polynomial
        powX = [zeros(1, i) 1:Dx+1-i];
        powY = [zeros(1, i) 1:Dy+1-i];
        
        % update conditions for x coordinate
        if ~isempty(cond{i,1})
            Aeqx = [Aeqx ; factY.*power(ti, powX)]; %#ok<AGROW>
            beqx = [beqx; cond{i,1}]; %#ok<AGROW>
        end

        % update conditions for y coordinate
        if ~isempty(cond{i,2})
            Aeqy = [Aeqy ; factY.*power(ti, powY)]; %#ok<AGROW>
            beqy = [beqy; cond{i,2}]; %#ok<AGROW>
        end
        
        % update polynomial degrees for next derivative
        factX = factX.*powX;
        factY = factY.*powY;
    end
    
    varargin(1:2)=[];
end


%% Initialisations

% ensure column vectors
t  = t(:);
xt = xt(:);
yt = yt(:);

% number of points to fit
L = length(t);


%% Compute coefficients of each polynomial

% avoid optimization warnings
warning('off', 'optim:lsqlin:LinConstraints');

% options to turn display off
options = optimset('display', 'off');

% main matrix for x coordinate, size L*(degX+1)
T = ones(L, Dx+1);
for i = 1:Dx
    T(:, i+1) = power(t, i);
end

% compute interpolation
xc = lsqlin(T, xt, zeros(1, Dx+1), 1, Aeqx, beqx, [], [], [], options)';

% main matrix for y coordinate, size L*(degY+1)
T = ones(L, Dy+1);
for i = 1:Dy
    T(:, i+1) = power(t, i);
end

% compute interpolation
yc = lsqlin(T, yt, zeros(1, Dy+1), 1, Aeqy, beqy, [], [], [], options)';


%% Format output arguments
if nargout <= 1
    varargout{1} = {xc, yc};
else
    varargout{1} = xc;
    varargout{2} = yc;
end
